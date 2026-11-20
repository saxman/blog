import { loadQuartzConfig, loadQuartzLayout } from "./quartz/plugins/loader/config-loader"
import SectionTitle from "./quartz/components/SectionTitle"

const config = await loadQuartzConfig()
export default config

// SectionTitle stands in for @quartz-community/page-title (disabled in quartz.config.yaml).
// Overrides replace a whole slot, so it is prepended to each left slot built from the YAML,
// including per-page-type ones (folder and tag pages build their own to exclude reader-mode).
// Slots cleared in the YAML, like the 404 page's, stay empty.
const sectionTitle = SectionTitle({ defaultTagSection: "meanderings" })
const yamlLayout = await loadQuartzLayout()
export const layout = await loadQuartzLayout({
  defaults: { left: [sectionTitle, ...(yamlLayout.defaults.left ?? [])] },
  byPageType: Object.fromEntries(
    Object.entries(yamlLayout.byPageType)
      .filter(([, pageLayout]) => pageLayout.left?.length)
      .map(([pageType, pageLayout]) => [pageType, { left: [sectionTitle, ...pageLayout.left!] }]),
  ),
})
