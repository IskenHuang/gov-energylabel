core = require('./core')

# form type:
#     tvSize:
# form url:
#     '/purchasing/compare/television.asp'

# tvSize
# 家庭人數
# 1.  小於30吋
# 30. 30吋
# 32. 32吋
# 37. 37吋
# 40. 40吋
# 42. 42吋
# 2.  大於42吋

exports = module.exports =

    getData: ->
        _data = []
        for i in [1, 2, 30, 32, 37, 40, 42]
            _data.push
                tvSize: i

        return _data

    rootURL: '/purchasing/compare/television.asp'

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
