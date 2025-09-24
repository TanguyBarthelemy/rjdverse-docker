pat <- Sys.getenv("GITHUB_PAT")
if (pat == "") {
    stop("❌ GITHUB_PAT is not set inside R")
} else {
    message("✅ GITHUB_PAT detected, first 6 chars: ", substr(pat, 1, 6))
}

url <- "https://api.github.com/repos/rjdverse/rjd3toolkit/tags"
res <- tryCatch(jsonlite::fromJSON(url), error = function(e) e)
if (inherits(res, "error")) {
    message("❌ Cannot reach GitHub API: ", res$message)
} else {
    message("✅ Tags retrieved: ", paste(head(res$name), collapse = ", "))
}

# Charger renv
if (!requireNamespace("renv", quietly = TRUE)) {
    install.packages("renv", repos = "https://cloud.r-project.org")
}
library(renv)

# Créer un projet temporaire si besoin
if (!file.exists("renv.lock")) {
    renv::init(bare = TRUE)
}

remotes::install_github("rjdverse/rjd3toolkit@v3.5.1")

# Déclarer tes dépendances GitHub
remotes <- c(
    "rjdverse/rjd3toolkit@v3.5.1",
    "rjdverse/rjd3x13@v3.5.1"
)

# Installer et enregistrer les packages
for (pkg in remotes) {
    renv::install(pkg)
}

# Snapshot pour figer l'état dans renv.lock
renv::snapshot(lockfile = "renv.lock", prompt = FALSE, type = "all")

cat("✅ renv.lock généré avec succès\n")
