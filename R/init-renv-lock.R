# Charger renv
if (!requireNamespace("renv", quietly = TRUE)) {
    install.packages("renv", repos = "https://cloud.r-project.org")
}
library(renv)

# Créer un projet temporaire si besoin
if (!file.exists("renv.lock")) {
    renv::init(bare = TRUE)
}

# Déclarer tes dépendances GitHub
remotes <- c(
    "rjdverse/rjd3toolkit@v3.5.1",
    "rjdverse/rjd3x13@v3.5.1"
)

# Installer et enregistrer les packages
for (pkg in remotes) {
    renv::install(pkg, type = "source", dependencies = "all")
}

# Snapshot pour figer l'état dans renv.lock
renv::snapshot(lockfile = "renv.lock", prompt = FALSE, type = "all")

cat("✅ renv.lock généré avec succès\n")
