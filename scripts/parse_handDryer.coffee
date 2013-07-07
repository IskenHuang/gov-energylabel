core = require('./core')

# form type:
#     S1:
# form url:
#     '/purchasing/compare/Hand_Dryer.asp'

# S1
# 烘手機種類
# 125. 觸控式
# 126. 感應式

exports = module.exports =

    getData: ->
        _data = []
        for i in [125, 126]
            _data.push
                S1: i

        return _data

    rootURL: '/purchasing/compare/Hand_Dryer.asp'

    parse: (options = { source: 'http' })->
        if options.source is 'file'
            for i in @getData()
                core.getFileFromArray
                    path: options.path
                , (result)->
                    console.log 'result = ', result
        else
            for i in @getData()
                core.getHTTPFromArray
                    url: @rootURL
                    body: i
                , (result)->
                    console.log 'result = ', result
