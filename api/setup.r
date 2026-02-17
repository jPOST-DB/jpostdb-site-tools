
# % Rscript setup.r

# インストールしたい全リスト
all_pkgs <- c("curl", "jsonlite", "exactRankTests", "BiocManager", "limma", "qvalue")

# まだインストールされていないパッケージを特定
new_pkgs <- all_pkgs[!(all_pkgs %in% installed.packages()[, "Package"])]

# 未インストールのものがあればインストールを実行
if (length(new_pkgs)) {
  # BiocManager が含まれている場合は先に CRAN から入れる
  if ("BiocManager" %in% new_pkgs) install.packages("BiocManager")
  
  # BiocManager を使えば CRAN と Bioconductor 両方を一括で扱えます
  BiocManager::install(new_pkgs)
}

