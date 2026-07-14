# Open Board Israel — Jobs, Talent & Employment Law (Community Hub)

Open, collaborative resources for **anyone looking for work in Israel** — including people **recently laid off**, career changers, olim, freelancers, and employers or connectors with open roles.

**Repository:** [github.com/northpointalliance/open-board-israel](https://github.com/northpointalliance/open-board-israel)

**Live site (Cloudflare Pages):**

| Page | URL |
|------|-----|
| **Daniel's Corner** — personal CV & job help | https://danielrosenthal-helpolim.pages.dev/ |
| **Open Board Israel** — community jobs & law | https://danielrosenthal-helpolim.pages.dev/board/ |
| Cloudflare dashboard | [danielrosenthal-helpolim](https://dash.cloudflare.com/df9a37eae256d721af313f9ccbb08bf4/pages/view/danielrosenthal-helpolim) |

---

## Quick start (15 minutes)

### 1. Create the Google Sheet (3 tabs)

1. Go to [Google Sheets](https://sheets.google.com) → **Blank spreadsheet**
2. Name it: **Open Board Israel — Jobs & Talent**
3. **File → Import** each CSV from the `sheets/` folder (one tab each):
   - `open-positions.csv` → rename tab **Open Positions**
   - `hr-referral-positions.csv` → rename tab **HR & Referrals**
   - `talent-profiles.csv` → rename tab **Talent Profiles**
   - `community-resources.csv` → rename tab **Community Resources** (wiki: attorneys, HR, olim services)
4. **Share → General access → Anyone with the link → Editor**  
   (Use **Commenter** instead if you want posts reviewed before they stick.)
5. Copy the sheet URL — you'll link it from your landing page.

### 2. Create the Google Doc (employment law)

1. Go to [Google Docs](https://docs.google.com) → **Blank document**
2. Name it: **Israeli Employment Law — English Reference (Open Board Israel)**
3. Open `docs/israeli-employment-law-reference.md`, copy all content, paste into the Doc
4. Format headings (Heading 1 / Heading 2) for navigation
5. **Share → Anyone with the link → Editor** (or Commenter if you prefer moderated edits)
6. Add a note at the top: *"Community resource — not legal advice. Verify with a lawyer for your situation."*

### 3. Deploy to Cloudflare Pages

Project: **danielrosenthal-helpolim** ([dashboard](https://dash.cloudflare.com/df9a37eae256d721af313f9ccbb08bf4/pages/view/danielrosenthal-helpolim))

```
open-board-israel/
├── index.html          → danielrosenthal-helpolim.pages.dev/
└── board/
    └── index.html      → danielrosenthal-helpolim.pages.dev/board/
```

1. Connect this folder to the Cloudflare Pages project (Git or **Direct Upload**)
2. Build command: none · Output directory: `/` (root)
3. After deploy, open `/board/` and replace `YOUR_GOOGLE_SHEET_URL` / `YOUR_GOOGLE_DOC_URL` in `board/index.html`, then redeploy

The two pages cross-link: **Daniel's Corner** (personal CV help) ↔ **Open Board** (community sheet).

## What each tab is for

| Tab | Who posts | Purpose |
|-----|-----------|---------|
| **Open Positions** | Anyone | Fast job posts: role, company, location, contact |
| **HR & Referrals** | HR, recruiters, people with connections | Verified or insider roles, referral-friendly |
| **Talent Profiles** | Job seekers (incl. recently laid off), freelancers, olim | Mini-CV, languages, travel radius, NIS hourly gigs |
| **Community Resources** | Anyone | Wiki-style directory: labor law attorneys, HR contacts, government links, olim services |

---

## Posting rules (paste at top of Sheet tab 1)

```
HOW TO POST A JOB (30 seconds)
1. Scroll to the first empty row
2. Fill: Date | Role | Company | Location | Type | Salary range (NIS) | Contact | Notes
3. Do not delete others' rows — add a new row only

RECRUITER & HR GUIDELINE (in-house / company recruiters)
- Do NOT ask applicants upfront what salary they expect.
- Israeli hiring often hides compensation; job seekers usually don't know what the role pays.
- Post the salary range (or best estimate) in the listing instead — that's fairer.
- This is the site owner's community standard, not legal advice.

HOW TO ADD YOUR PROFILE
→ Go to the "Talent Profiles" tab
```

---

## Keeping it safe & useful

- **No passwords, ID numbers, or full addresses** in public rows — use email / LinkedIn / phone only if comfortable
- Pin the **minimum wage** row in the law doc (updates every April 1)
- Assign 1–2 moderators to hide spam rows (View → Hidden rows) or switch sheet to Commenter + weekly approval
- Add a **Last verified** column when community members confirm a law figure or job is still open
- **Salary transparency:** In-house recruiters should post a salary range and avoid leading with "what are your salary expectations?" — applicants often lack pay information in Israel

---

## Files in this repo

```
open-board-israel/
├── README.md
├── index.html                             ← Daniel's Corner (home)
├── board/
│   └── index.html                         ← Open Board Israel
├── docs/
│   └── israeli-employment-law-reference.md
└── sheets/
    ├── open-positions.csv
    ├── hr-referral-positions.csv
    ├── talent-profiles.csv
    └── community-resources.csv
```

---

## Minimum wage quick reference (April 1, 2026)

| | NIS |
|---|-----|
| Monthly (full-time) | 6,443.85 |
| Hourly (182 hr/month) | 35.40 |
| Hourly (186 hr/month) | 34.64 |

Source: [National Insurance Institute — Minimum Wage](https://www.btl.gov.il/English%20Homepage/Mediniyut/GeneralInformation/Pages/MinimumWage.aspx)
