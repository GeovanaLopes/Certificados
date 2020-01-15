
# carregar lista de participantes e substituir na variável 'lista'

lista <- c("teste1","teste2","teste3") 


purrr::walk(lista,
            ~rmarkdown::render('.//certificados.Rmd', 
            params = list(teste = .), 
            output_file = glue::glue('.//file_{.}.html')))
                              
                        