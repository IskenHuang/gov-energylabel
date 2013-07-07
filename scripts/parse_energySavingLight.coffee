core = require('./core')
# 安定器內藏式螢光燈泡

# form type:
#     S1:
#     subtype:
#     sizecode:
# form url:
#     '/purchasing/compare/energy_saving_light.asp'

# S1
# 電燈泡分類
# 148. 無罩
# 149. 有罩

# subtype
# sizecode
# 瓦數分類

# 電燈泡分類
# 148. 無罩
# 10. <=10W
# 11. 11~15W
# 16. >16~25W
# 26. >25W

# 149. 有罩
# 14. <=15W
# 15. 15~20W
# 20. 20~25W
# 26. >25W


exports = module.exports =
    get148: [10, 11, 16, 26]

    get149: [14, 15, 20, 26]

    getData: ->
        _data = []
        for i in [148, 149]
            if i is 148
                _a = @get148
            else
                _a = @get149

            for j in _a
                _data.push
                    S1: i
                    subtype: j
                    sizecode: j

        return _data

    rootURL: '/purchasing/compare/energy_saving_light.asp'

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
