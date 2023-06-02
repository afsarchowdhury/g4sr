.onAttach <- function(libname, pkgname) {
  packageStartupMessage(
    paste0(
      "You will need a valid API key to access the functions in this pacakge.",
      "\nAsk your school administrator to generate one for you.",
      "\nLog errors and bugs at https://github.com/afsarchowdhury/g4sr/issues."
    )
  )

  packageStartupMessage(
    message(cat(crayon::cyan("Type citation('g4sr') to cite g4sr in a publication.")))
  )
}
