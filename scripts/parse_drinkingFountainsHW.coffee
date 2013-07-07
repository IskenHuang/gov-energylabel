core = require('./core')

# form type:
#     drink:
# form url:
#     '/purchasing/compare/drinking_Fountains_HW.asp'

# drink
# 熱水容量
# 1. 4公升以上
# 2. 低於4公升

exports = module.exports =

    getData: ->
        _data = []
        for i in [1, 2]
            _data.push
                drink: i

        return _data

    rootURL: '/purchasing/compare/drinking_Fountains_HW.asp'

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
                    # console.log 'result = ', result
