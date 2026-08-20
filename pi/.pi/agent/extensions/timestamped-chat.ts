import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { Text } from "@earendil-works/pi-tui";

type TimestampEntryData = {
	role: "user" | "assistant" | "toolResult";
	timestamp: number;
	toolName?: string;
};

type StateEntryData = {
	enabled: boolean;
};

const TIMESTAMP_ENTRY = "timestamped-chat";
const STATE_ENTRY = "timestamped-chat-state";

function formatTimestamp(timestamp: number): string {
	return new Intl.DateTimeFormat("en-US", {
		month: "short",
		day: "numeric",
		hour: "numeric",
		minute: "2-digit",
		hour12: true,
	})
		.format(new Date(timestamp))
		.replace(/\b(AM|PM)\b/g, (match) => match.toLowerCase());
}

function labelFor(data: TimestampEntryData): string {
	if (data.role === "toolResult") {
		return data.toolName ? `Tool result (${data.toolName})` : "Tool result";
	}

	return data.role === "user" ? (process.env.USERNAME || process.env.USER || "User") : "Pio";
}

export default function (pi: ExtensionAPI) {
	let enabled = true;

	function setStatus(ctx: { ui?: { setStatus?: (key: string, value: string) => void } }) {
		ctx.ui?.setStatus?.("timestamps", enabled ? "timestamps: on" : "timestamps: off");
	}

	pi.registerEntryRenderer<TimestampEntryData>(TIMESTAMP_ENTRY, (entry, _options, theme) => {
		if (!enabled) return undefined;

		const data = entry.data;
		if (!data) return undefined;

		const text = `${labelFor(data)} · ${formatTimestamp(data.timestamp)}`;
		return new Text(theme.fg("dim", text), 0, 0);
	});

	pi.on("session_start", (_event, ctx) => {
		for (const entry of ctx.sessionManager.getEntries()) {
			if (entry.type !== "custom" || entry.customType !== STATE_ENTRY) continue;
			const data = entry.data as StateEntryData | undefined;
			if (typeof data?.enabled === "boolean") enabled = data.enabled;
		}

		setStatus(ctx);
	});

	pi.on("message_start", (event) => {
		if (!enabled) return;

		const { message } = event;
		if (message.role !== "user" && message.role !== "assistant" && message.role !== "toolResult") return;

		pi.appendEntry<TimestampEntryData>(TIMESTAMP_ENTRY, {
			role: message.role,
			timestamp: message.timestamp ?? Date.now(),
			toolName: message.role === "toolResult" ? message.toolName : undefined,
		});
	});

	pi.registerCommand("timestamps", {
		description: "Toggle timestamp markers for user, assistant, and tool result messages. Usage: /timestamps [on|off|status]",
		handler: async (args, ctx) => {
			const arg = args.trim().toLowerCase();

			if (arg === "on") enabled = true;
			else if (arg === "off") enabled = false;
			else if (arg === "" || arg === "toggle") enabled = !enabled;
			else if (arg !== "status") {
				ctx.ui.notify("Usage: /timestamps [on|off|status]", "warning");
				return;
			}

			pi.appendEntry<StateEntryData>(STATE_ENTRY, { enabled });
			setStatus(ctx);
			ctx.ui.notify(`Timestamps ${enabled ? "enabled" : "disabled"}.`, "info");
		},
	});
}
