# Conversational Workspace UX

## Entry and states

The website may show a compact branded launcher/inline CTA, but activation expands into a dedicated workspace. Desktop: centered overlay or route-level workspace up to 1200 px; conversation initially dominant. A contextual “What I understand / opportunities / brief” rail emerges after a real artifact exists, collapsible and never shown as an empty dashboard. Tablet uses a conversation canvas with contextual drawer. Mobile is full-screen within the visual viewport.

Open state presents a specific prompt adapted from page context without asserting knowledge, four optional intents, and free text. Example: “What are we solving?” with “Explore a business challenge”, “Find where AI could help”, “Discuss a new project”, “I'm already a client”.

## Conversation behavior

- Assistant messages use readable blocks, not decorative chat bubbles for every paragraph; user messages may be compact bubbles.
- Maximum text measure 65 characters; body 16–18 px; line height 1.5; timestamps/status are secondary but accessible.
- Stream text in coherent chunks. Keep a stable live region and avoid screen-reader announcement per token; announce completion/progress changes.
- Show truthful progress steps (“Website received”, “Reviewing messaging”), not generic fake “thinking” or percentage.
- Composer grows to 6 lines, supports Shift+Enter newline and Enter send on desktop; on mobile Enter behavior follows keyboard/input conventions with explicit send button.
- Sending is optimistic only for the local user message; server acknowledgment controls accepted status. Prevent duplicate sends with client message ID.
- Stop generation is available; retry creates a new run linked to prior failure, never overwrites history.
- Auto-scroll only when user is near bottom. If they scroll up, preserve position and show “new response” control.
- Cards appear in the transcript and can update only via a new version/status event; historical records remain understandable.
- Resume shows a short summary, time and privacy; stale actionable cards are disabled/refreshable.

## Keyboard/focus

Launcher focus moves to workspace heading; close returns to launcher. Escape closes only non-destructive overlays, not the whole workspace while typing without confirmation. Tab order follows content, actions, composer. Focus is not moved on every new message. Pending confirmation moves focus only after announcing it and retains a cancel path.

## Error/degraded states

Offline: keep draft, show status, retry after connection. Model failure: preserve message and offer retry/human/static contact. CRM/calendar failure: state what was saved and what remains pending. Expired session/action: explain and re-establish safely. Rate limit: show retry time. No failure claims an action completed.

## Privacy

Before first message, concise notice links details. Separate optional analytics/cookie consent from necessary conversation processing. Before identity/follow-up/upload/website audit, show purpose-specific consent. Never use manipulative countdowns or hide human contact.
