
# carregar lista de participantes e substituir na variável 'lista'

lista <- c("teste1","teste2","teste3")


# Gerar arquivos html
purrr::walk(lista,
            ~rmarkdown::render("certificados/modelo_certificados.Rmd",
            params = list(nome = .),
            output_file = glue::glue('Certificado_R-Ladies_{.}.html')))


# Gerar os PDF's
purrr::walk(.x= list.files( pattern = "\\.html$", recursive = TRUE),
            .f = pagedown::chrome_print)

