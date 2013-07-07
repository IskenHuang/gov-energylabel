core = require('./core')
# 組合音響

# form type:

# form url:
#     '/purchasing/compare/stereo.asp'


exports = module.exports =

    rootURL: '/purchasing/compare/stereo.asp'

    parse: (options = { source: 'http' })->
        if options.source is 'file'
            core.getFileFromArray
                path: options.path
            , (result)->
                console.log 'result = ', result
        else
            core.getHTTPFromArray
                url: @rootURL
            , (result)->
                console.log 'result = ', result
