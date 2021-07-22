.onAttach <- function(libname, pkgname) {
  packageStartupMessage(paste0(
    "Welcome to g4sr.",
    "\n\nThis package is released under GPLv3.",
    "\n\nLog issues at https://github.com/afsarchowdhury/g4sr/issues.",
    "\n\nYou will need a valid API key to access the functions in this pacakge.",
    "\nAsk your school administrator to generate one for you."
  ))
}
