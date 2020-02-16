library(readxl)
library(dplyr)
library(janitor)
library(tidyverse)

# abrir a lista de presenca

lista_de_presenca <-
  read_excel(
    "certificados/lista-preenchida.xlsx",
    col_types = c("skip", "text", "skip",
                  "text", "text")
  ) %>% janitor::clean_names() %>%
  filter(presenca == "presente")


# Organizadoras - Ler arquivos

lista_de_presenca_organizadoras <-
  lista_de_presenca %>% filter(observacao == "Organização") %>%
  select(nome_completo) %>%
  as_vector()

# Organizadoras - gerar certificados em html
purrr::walk(
  lista_de_presenca_organizadoras,
  ~ rmarkdown::render(
    "certificados/modelo_certificados.Rmd",
    params = list(nome_participante = ., tipo_participacao = "organizadora(o)"),
    output_file = glue::glue('Certificado_Organizacao_R-Ladies_{.}.html')
  )
)

# ------------

# Participantes - ler arquivo

lista_de_presenca_participantes <-
  lista_de_presenca %>% filter(observacao == "Participante") %>%
  select(nome_completo) %>%
  as_vector()



# Gerar arquivos html das participantes

purrr::walk(
  lista_de_presenca_participantes,
  ~ rmarkdown::render(
    "certificados/modelo_certificados.Rmd",
    params = list(nome_participante = .),
    output_file = glue::glue('Certificado_R-Ladies_{.}.html')
  )
)

# -------------------
# Gerar os PDF's de todos os HTML na pasta
purrr::walk(.x = list.files(pattern = "\\.html$", recursive = TRUE),
            .f = pagedown::chrome_print)


beepr::beep() # a etapa de gerar os PDFs demora.
# A função beep faz um aviso sonoro para saber que terminou!
