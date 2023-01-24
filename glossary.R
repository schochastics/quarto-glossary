files <- Sys.getenv("QUARTO_PROJECT_INPUT_FILES")
glossary <- readLines("glossary.md")
terms <- glossary[stringr::str_detect(glossary, "^## ")] |> stringr::str_remove_all("## ")

for (f in files){
    if (f != "glossary.md"){
      co <- readLines(f)
      if (any(stringr::str_detect(co, paste0(terms, collapse = "|")))) {
          print(f)
          co <- stringi::stri_replace_all_regex(co, paste0("(?<![:#])", terms),
              paste0("[:", terms, "](/glossary.html#", terms, ")"), vectorize_all = FALSE)
          writeLines(co, f)
      }
    }
}