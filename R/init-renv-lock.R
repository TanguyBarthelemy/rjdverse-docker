# Charger renv
if (!requireNamespace("renv", quietly = TRUE)) {
  install.packages("renv", repos = "https://cloud.r-project.org")
}
library(renv)

# Créer un projet temporaire si besoin
if (!file.exists("renv.lock")) {
  renv::init()
}

options(renv.config.install.remotes = FALSE)

# Déclarer tes dépendances GitHub
remotes <- c(
  "remotes",
  "RJDemetra", 
  "rjwsacruncher", 
  "rjdworkspace", 
  "JDCruncheR", 
  "ggdemetra", 
  "rjdmarkdown", 
  "rjdqa",
  "rjdverse/rjd3toolkit@v3.5.1",
  "rjdverse/rjd3x13@v3.5.1", 
  "rjdverse/rjd3tramoseats@v3.5.2",
  "rjdverse/rjd3providers@v3.5.1",
  "rjdverse/rjd3workspace@v3.5.1",
  "rjdverse/rjd3filters@v2.3.0",
  "rjdverse/rjd3x11plus@v2.3.0",
  "rjdverse/rjd3bench@v3.0.0",
  "rjdverse/rjd3nowcasting@v2.0.3",
  "rjdverse/rjd3revisions@v1.4.1",
  "TanguyBarthelemy/rjd3production"
)

pkg_remotes <- c("rjdverse/rjd3sts@v2.3.0",
                 "rjdverse/rjd3highfreq@v2.3.0",
                 "rjdverse/rjd3stl@v2.3.0",
                 "AQLT/ggdemetra3",
                 "AQLT/rjd3report")

# Installer et enregistrer les packages
for (pkg in remotes) {
  renv::install(pkg, type = "source", dependencies = "all", prompt = FALSE)
}

# # Installer et enregistrer les packages
# for (pkg in pkg_remotes) {
#   remotes::install_github(pkg, type = "source", dependencies = TRUE)
# }

# Snapshot pour figer l'état dans renv.lock
renv::snapshot(lockfile = "renv.lock", prompt = FALSE, type = "all")

cat("✅ renv.lock généré avec succès\n")
