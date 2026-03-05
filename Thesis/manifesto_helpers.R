suppressPackageStartupMessages({
  library(stringr)
})

# ------------------------------------------------------------
# normalize_text()
# ------------------------------------------------------------
# Clean one text string by:
#   - optionally lowercasing
#   - removing non-breaking spaces and control characters
#   - normalizing whitespace (trim + collapse repeated spaces)
#
# Why:
#   Text extracted from PDFs often contains messy whitespace and formatting artifacts.
#   Normalizing early makes later counting more reliable and reproducible.
#
# Args:
#   x: character string (ideally length 1)
#   to_lower: logical, whether to lowercase the text
#
# Returns:
#   a cleaned single string, or NA_character_ if missing/empty
normalize_text <- function(x, to_lower = TRUE) {
  if (length(x) == 0 || is.na(x)) return(NA_character_)
  
  out <- x  # Work on a copy so the original object isn't mutated unexpectedly.
  out <- str_replace_all(out, "\u00A0", " ")   # non-breaking spaces
  out <- str_replace_all(out, "[\r\t]+", " ")  # tabs/carriage returns
  
  # Optional lowercasing for case-insensitive matching consistency.
  # (You still also do ignore_case later, but this helps standardize text.)
  if (to_lower) out <- str_to_lower(out)
  
  out <- str_squish(out)  # trim + collapse repeated whitespace
  out   # Return cleaned string
}

# Escape regex metacharacters and build a whole-word pattern
build_marker_regex <- function(marker) {
  safe <- str_replace_all(
    marker,
    "([.\\+\\*\\?\\^\\$\\(\\)\\[\\]\\{\\}\\|\\\\])",
    "\\\\\\1"
  )
  paste0("\\b", safe, "\\b")
}

