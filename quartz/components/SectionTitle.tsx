import { QuartzComponent, QuartzComponentConstructor, QuartzComponentProps } from "./types"
import { classNames } from "../util/lang"
import { FullSlug, pathToRoot, resolveRelative } from "../util/path"

interface Options {
  /** Section that owns tag pages whose first segment is not a section folder (e.g. tags/philosophy). */
  defaultTagSection: string
}

// Replaces @quartz-community/page-title: shows the title of the top-level section a page belongs
// to (taken from that section's index.md) and links to it, falling back to the site title.
export default ((opts: Options) => {
  const SectionTitle: QuartzComponent = ({
    fileData,
    allFiles,
    cfg,
    displayClass,
  }: QuartzComponentProps) => {
    const slug = fileData.slug as FullSlug
    const sectionTitles = new Map(
      allFiles
        .filter((file) => file.slug?.match(/^[^/]+\/index$/) && file.frontmatter?.title)
        .map((file) => [file.slug!.split("/")[0], file.frontmatter!.title as string]),
    )
    // The tag index is a top-level folder page too, but tag pages belong to the section of their tag.
    sectionTitles.delete("tags")

    const [first, second] = slug.split("/")
    let section: string | undefined
    if (first === "tags") {
      if (second && second !== "index") {
        section = sectionTitles.has(second) ? second : opts.defaultTagSection
      }
    } else if (sectionTitles.has(first)) {
      section = first
    }

    const title = section && sectionTitles.get(section)
    const href = title ? resolveRelative(slug, `${section}/index` as FullSlug) : pathToRoot(slug)
    return (
      <h2 class={classNames(displayClass, "page-title")}>
        <a href={href}>{title ?? cfg.pageTitle}</a>
      </h2>
    )
  }

  SectionTitle.css = `
.page-title {
  font-size: 1.75rem;
  margin: 0;
  font-family: var(--titleFont);
}
`

  return SectionTitle
}) satisfies QuartzComponentConstructor<Options>
