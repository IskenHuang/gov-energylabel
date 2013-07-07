core = require('./core')
# 出口標示燈及避難方向指示燈

# form type:
#     S1:
#     S2:
# form url:
#     '/purchasing/compare/exit_light.asp'

# S1
# 燈具等級
# 109. A級
# 110. B級
# 111. C級

# S2
# 燈具類別
# 112. 出口指示燈
# 113. 避難方向指示燈

exports = module.exports =

    getData: ->
        _data = []
        for i in [ 109, 110, 111]
            for j in [ 112, 113]
                _data.push
                    S1: i
                    S2: j

        return _data

    rootURL: '/purchasing/compare/exit_light.asp'

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
