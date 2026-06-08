name: security-audit
description: Identify security vulnerabilities — save file integrity checks (encryption, validation), input validation (command injection, eval), secrets in source code (API keys, credentials), network message security (HTTPS, authentication). Produces severity-classified report with specific file paths.
allowed-tools: read_file, search_files, write_file, clarify
model: sonnet
agent: security-engineer

Security Audit — Vulnerability Assessment

Reviews the project for common game security vulnerabilities and produces a severity-classified report.
This skill is READ-ONLY unless the user asks for fixes.

Output: docs/security/audit-[date].md

---

Phase 1: Save File Security

Search for save/load code:
- search_files(pattern='save|load|FileAccess|WriteFile|ReadFile|SaveGame|PlayerPrefs', path='src/')
- Read save file implementation if found.

Check:
1a. Is save data encrypted? If plain JSON/text: "Save data is unencrypted. Players can edit their saves."
  Severity: LOW for single-player (self-cheating), HIGH for multiplayer (competitive advantage)

1b. Is save data validated on load? Check for checksums or integrity checks.
  If missing: "No save integrity check. Corrupted or tampered saves can crash the game."
  Severity: MEDIUM

1c. Is there anti-tamper? (checksums, HMAC, obfuscation)
  If none: "No anti-tamper measures. Save editing is trivial."
  Severity: LOW (acceptable for single-player)

---

Phase 2: Input Validation

Search for external data input:
- Command line arguments: read project startup code
- Network input: search for "http", "ws://", "socket"
- User text input: search for "LineEdit", "TextField", "InputField"
- File parsing: search for "parse", "load", "read", "import"

Check:
2a. File path injection: if user input is used to construct file paths:
  "User-controlled file path at [file:line]. Path traversal attack possible."
  Severity: HIGH

2b. Dynamic execution: search for "eval(", "execute(", "run(", "load()" with dynamic input
  "Dynamic code execution at [file:line]. Arbitrary code execution risk."
  Severity: CRITICAL

2c. Command injection: search for "OS.execute(", "Process.Start(", "system(" with user input
  "Command execution with user input at [file:line]. Command injection risk."
  Severity: CRITICAL

---

Phase 3: Secrets in Source

Search the project for API keys, tokens, credentials:
- search_files(pattern='api_key|apikey|secret|token|sk-|pk-|password|passwd|connectionString', path='.')
- Check .env files, config files, and source files separately

If found: list each with exact file path and line number.
"Secret found at [file:line]. Remove from source code. Use environment variables or a secrets manager."
Severity: CRITICAL (if the secret is active)

Safe patterns: secrets in environment variables, .env files (gitignored), cloud secret manager.

---

Phase 4: Network Security

Search for network communication code:
- search_files(pattern='http://|https://|ws://|wss://|tcp|udp|socket|request|fetch', path='src/')

Check:
4a. Is HTTPS used instead of HTTP? If HTTP: "Unencrypted communication at [file:line]. Data can be intercepted."
  Severity: HIGH (if any sensitive data is transmitted)

4b. Are server calls authenticated? Check for auth tokens, sessions, signatures.
  If missing: "Unauthenticated API calls at [file:line]. Anyone can call this endpoint."
  Severity: HIGH

4c. Are error messages leaking sensitive info? Check error handling in network code.
  "Error response at [file:line] may leak server information."
  Severity: MEDIUM

---

Phase 5: Report

Write to docs/security/audit-[date].md:

```
# Security Audit: [date]

## CRITICAL (fix immediately)
[Items with file paths and descriptions]

## HIGH (fix this sprint)
[Items]

## MEDIUM (fix when convenient)
[Items]

## LOW (awareness)
[Items]

## Not Audited
[Areas that couldn't be checked]
- [Reason: no network code to scan, no save system, etc.]

## Summary
- CRITICAL: [N]
- HIGH: [N]
- MEDIUM: [N]
- LOW: [N]
```

---

Phase 6: Post-Checks

- If CRITICAL found: "Found [N] critical security issues. Should I start fixing them now?"
  - If yes: fix each one. Use patch to remove secrets, add HTTPS enforcement, etc.
- If no issues: "No security vulnerabilities detected. Run again after adding networking or online features."
- If audit couldn't complete (missing dependencies, can't read files): note: "Partial audit — [reason]. Re-run after resolving."

---

Phase 7: Remediation Guidance

For each CRITICAL/HIGH finding, provide a specific fix:
- Secret in source: "Move [secret] to .env file. Read with: ENV.get('API_KEY'). Add .env to .gitignore."
- No HTTPS: "Change 'http://' to 'https://' at [file:line]. Update any hardcoded URLs."
- No input validation: "Add validation before [line]: check type, length, allowed characters."
- No save encryption: "Add a simple checksum: hash the save data and store it alongside. Verify on load."

Offer to implement: "Should I apply the fix for [finding N]?"

---

Phase 8: Risk Assessment

Score each finding by:

Likelihood × Impact = Risk Score
| Finding | Likelihood | Impact | Score |
|---|---|---|---|
| Secret in source | High | Critical | CRITICAL |
| No HTTPS on public server | Medium | High | HIGH |
| No save encryption | Low | Medium | LOW |

- CRITICAL risk (score 15-25): Block release
- HIGH risk (score 10-14): Fix before launch
- MEDIUM risk (score 5-9): Fix when possible
- LOW risk (score 1-4): Track, defer

---

Phase 9: Rescan Verification

After any fixes are applied:
- Re-run the relevant scan checks
- Confirm the finding is resolved
- If multiple items were fixed: update the register
- "Re-scanned [area]. Finding [N] is resolved. [N] remaining."

---

Edge Cases

- No source code to scan: "No code found. Run after implementing systems."
- Engine has its own security model (e.g., Godot's web export sandboxing): Note: "Engine-level protections may mitigate some risks. Verify per platform."
- False positive: If a flagged item is intentionally insecure (e.g., debug mode): "Flagged but intentional: [reason]. Add comment to suppress warning."
