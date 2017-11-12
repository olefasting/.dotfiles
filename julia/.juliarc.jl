using OhMyREPL

const WORKSPACE_FILE_NAME = "_init.jl"

if isfile(pwd() + WORKSPACE_FILE_NAME)
    include(WORKSPACE_FILE_NAME)
end

##if WORD_SIZE == 64
##    ENV["JULIA_PKGDIR"] = Pkg.dir() * "64"
##end
