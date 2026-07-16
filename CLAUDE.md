# CLAUDE.md — working notes for this résumé repo

Context and decisions for Claude Code sessions. The résumé source lives in `current/`.

## Build & preview

- **Root file:** `current/EleanorNicolsonResume.tex`. Engine: **pdfLaTeX** (not xelatex — the class uses no fontspec). Bibliography via **biber**.
- **Build sequence** (run inside `current/`): `pdflatex` → `biber` → `pdflatex` → `pdflatex`.
- The document **must stay 2 pages** (page 1 front, page 2 reverse) and compile with **no biber warnings**. Adding content to page 1 pushes against this — check the page count on every change.
- **Preview** a build by rendering to PNG: `pdftoppm -png -r 150 EleanorNicolsonResume.pdf out` and open `out-1.png` / `out-2.png`.
- `current/EleanorNicolsonResume.pdf` is **committed** (the README links it). Rebuild and commit it whenever a `.tex`/`.cls` changes, or the published PDF goes stale.

### Toolchain on a fresh machine

Beyond base TeX Live you need: `texlive-latex-recommended latex-extra fonts-recommended fonts-extra pictures bibtex-extra humanities` and `biber`. These supply `soul.sty`, `fontawesome5`, tikz/pgf, and the biblatex **`reading`** style (`reading.bbx`). On Claude Code web, third-party apt PPAs return 403 — disable them before `apt-get update`.

### CI

`.github/workflows/build.yml` compiles the résumé on every PR and push to `main` (via `xu-cheng/latex-action`, which bundles TeX Live + biber and auto-runs biber through `latexmk`) and uploads the PDF as a downloadable artifact. The check is named **`build`** — add it to the `main` ruleset to require it. Note: a required check only gates *future* PRs, not one already open.

## Layout knobs (`current/developercv.cls`)

- `\entryskip` (2mm): vertical gap between entries in an `entrylist`. Page 1 is tight; this was tuned to keep everything on 2 pages.
- `\cvsectskip` (0.6\baselineskip): uniform whitespace **above every section heading** (`\cvsect`). One knob controls all headings — don't reintroduce ad-hoc `\vspace` between sections.
- The `entrylist` environment ends with `\vspace{-\entryskip}` to cancel the last entry's trailing gap, so the space *above* the following heading stays uniform. (Without it, sections after an entry-list gained extra space.)
- The skills grid used to hug its heading because the skill `minipage`s carried a leftover `\vspace{-\baselineskip}` from the old bar-chart design. It's been removed — don't add it back.

## Template conventions

- **Entries:** `\entry[Role]{dates}{team/heading}{company}{description}`. `[Role]` is an **optional first arg**, rendered as ", Role." at the end of the heading. Omit it for Research / Miscellaneous / Education entries, where the heading already *is* the role.
- **Single-bullet entries** render as a **paragraph** (write the sentence directly, no `\noseplist`), not a lone bullet.
- **Skills** (`current/IntroductionSkillsTechnology.tex`): `\dotskill{Label}{n}` renders the label plus an `n`-of-5 dot rating. Three columns grouped by category (programming languages / platforms / tools & query languages), ordered by **proficiency descending, alphabetical tiebreak**. Can expand to a 4th column if needed (see the note in that file). `\pierating` is an alternative pie-style rating that was prototyped and kept, but **dots were chosen for legibility** (a 3/5 vs 4/5 pie is hard to distinguish).

## Content decisions for this résumé

- **Objective:** role-neutral, framed around building durable platform & data infrastructure. Eleanor's own wording — don't rewrite without asking.
- **Applied Intuition = two separate entries**, by design (distinct roles/scope, don't merge):
  - *Software Engineer* (10/2023 – 10/2025): code-coverage tooling, test-reporting infrastructure, Buildkite CI/CD, software-in-the-loop testing.
  - *Tech Lead* (10/2025 – present): Neptune/Gremlin traceability graph, Terraform productization, agentic-engineering practices.
- **Permanently out of scope:** Polarion / ALM detail and SysMLv2 — do not add these, even if they seem relevant.
- The 2017 internship lives on the **reverse page** (`current/InternshipExperience.tex`).
- **Leave alone unless explicitly asked:** `Education.tex`, `ResearchExperience.tex`, `MiscellaneousExperience.tex`, `FunFacts.tex`, `law_school/`, `archived/`.

## Working style

- Facts only Eleanor can supply — exact dates, accomplishments and their scale/scope, skill ratings — must **come from her; never invent numbers** on a résumé.
- **Show the rendered PDF before pushing** to remote.
- Commit frequently, but **consolidate into a clean sequence before pushing**.
