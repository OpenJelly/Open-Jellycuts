import Runestone
import TreeSitterJelly
import TreeSitterJellyQueries

public extension TreeSitterLanguage {
    static var jelly: TreeSitterLanguage {
        let highlightsQuery = TreeSitterLanguage.Query(contentsOf: TreeSitterJellyQueries.Query.highlightsFileURL)
        let injectionsQuery = TreeSitterLanguage.Query(contentsOf: TreeSitterJellyQueries.Query.injectionsFileURL)
        return TreeSitterLanguage(tree_sitter_jelly(), highlightsQuery: highlightsQuery, injectionsQuery: injectionsQuery, indentationScopes: nil)
    }
}
