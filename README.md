# saxman.info/blog

Source for <https://saxman.info/blog>, built with [Quartz](https://quartz.jzhao.xyz) v5.

`blog/` is the site root and a single **Obsidian vault** (named `blog`). Each folder inside it is a section of the site:

| Folder | Site section | What's in it |
| --- | --- | --- |
| `blog/meanderings/` | `/blog/meanderings` | The blog: Discoveries, Factoids, and Meandering Thoughts |
| `blog/engineering/` | `/blog/engineering` | Engineering references, mostly AI |
| `blog/public-health/` | `/blog/public-health` | Public health policy references, mostly disease modeling |

`blog/index.md` is the landing page linking the three sections.

## Layout

| Path | Purpose |
| --- | --- |
| `<section>/posts/` | Published notes. Meanderings: blog posts (`YYYY-MM-DD-topic-subject.md`). Engineering and public-health: one reference note per bookmark (`YYYY-MM-DD-name.md`) |
| `<section>/index.md` | The section's home page |
| `<section>/drafts/` | Work-in-progress notes. New notes from Obsidian go to `meanderings/drafts/`. Never published (ignored by Quartz) |
| `<section>/attachments/` | Images and other files that notes embed. Obsidian saves pasted files to `meanderings/attachments/` |
| `templates/` | Obsidian templates (`post.md` for the blog, `reference.md` for references). Never published |
| `private/` | Not published or committed. Holds Copilot plugin data (`private/copilot/`) |
| `obsidian-web-clipper/` | Importable Web Clipper templates |
| `scripts/` | `update-clipper-templates.ps1` regenerates the Interpreter templates from the current tags |

Notes with `draft: true` aren't published, in any section.

## References

Reference notes carry extra fields: `type` (paper, article, repo, tool, project, model, dataset, program, course, link), `source` (the URL), `published`, `author`, and `summary_by: ai` when the Interpreter wrote the description.
Topics are nested tags under `engineering/ai/...` and `public-health/...`. A reference can carry tags from both, e.g. an AI paper about epidemic modeling.

## Organizing posts

Topics are **nested tags**, not folders, so a post can belong to several topics:

```yaml
tags:
  - language/japanese
  - culture/japan
  - series/word-of-the-day
```

Top-level topics: `philosophy`, `language`, `linguistics`, `culture`, `history`, `religion`, `science`, `mathematics`, `arts`, `food`, `travel`, `folklore`, `humor`, `technology`, `environment`.
Recurring formats live under `series/`: `word-of-the-day`, `phrase-of-the-day`, `philosophy-of-the-day`, `science-of-the-day`, `quotes`, `reading-list`, `photos`.

Post titles start with their top-level topic, e.g. "Language: Hubris" or "Philosophy: Zazen".
Quartz generates a page for every tag, and parent tags list their children (e.g. `/blog/tags/language`).
Before inventing a new tag, check Obsidian's Tags pane and reuse an existing one if it fits.

## Writing workflow

1. **Clip:** use one of the Web Clipper templates in `obsidian-web-clipper/`. Each targets one section, and saves with `draft: true`.
   - "Meanderings (excerpt)" and "Meanderings (summary)" save to `meanderings/posts/`. They use Web Clipper's Interpreter (an LLM) to write the "Topic: Subject" title, filename and tags, and to quote or summarize the page.
   - "Engineering" and "Public health" save to `posts/` in their section, with an AI-written description, type, and tags. "Engineering" is picked automatically on arxiv.org, github.com, and huggingface.co.
   - Tags are chosen from the tags already used in each section. After adding new tags, run `pwsh scripts/update-clipper-templates.ps1` and re-import the templates.
2. **Edit:** add your own commentary and tags.
3. **Publish:** set `draft: false` (or delete the line), then commit and push. GitHub Actions builds and deploys.

Any note with `draft: true` is excluded from the site, but it is still visible in the GitHub repo if the repo is public.

## Local preview

Requires Node.js 22+.

```sh
npm ci
npx quartz plugin install
npx quartz build -d blog --serve   # http://localhost:8080
```

Quartz defaults to a `content/` folder, so pass `-d blog` to every `quartz` command (`build`, `update`, `sync`).

## Updating Quartz

The `upstream` remote points to `jackyzha0/quartz`. Leave `quartz.config.default.yaml` untouched so updates merge cleanly; site settings are in `quartz.config.yaml`.
Local change to Quartz itself: an `index-only` layout condition in `quartz/plugins/loader/conditions.ts`, which shows Recently Added on the landing page only.
