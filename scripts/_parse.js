var fs = require('fs'),
    request = require('request'),
    cheerio = require('cheerio'),
    iconv = require('iconv-lite'),
    baseURL = 'http://www.energylabel.org.tw/',
    targetURL = 'http://www.energylabel.org.tw/purchasing/compare/list.asp',
    // targetURL = 'http://dict.revised.moe.edu.tw/',
    // targetURL = 'http://www.energylabel.org.tw/purchasing/compare/fan.asp',
    inputFiles = ['./30.txt', './35.txt', './40.txt', './50.txt'];


var getDomHtml = function getDomHtml(url, cb) {
        request( {
            url: url,
            encoding: 'binary'
        }, function (error, response) {
            if (!error && response.statusCode === 200) {
                var _buf = iconv.encode( response.body, 'binary'),
                    _html = iconv.decode( _buf, 'big5');
                $ = cheerio.load(_html);

                var tmpArray = url.split('/'),
                    fn = tmpArray[tmpArray.length-1].split('.')[0];

                savefile(new Date().getTime()+'_'+fn, _html);

                cb($);
            }else{
                console.log('error = ', error);
                console.log('url = ', url);
                // console.log('response = ', response);
            }

        });
    },
    getDomHtmlLinks = function getDomHtmlLinks( $, cb) {
        var _array = [];
        $('html a').each(function(index, item){
            var _url = $(item).attr('href');
            if(_url.indexOf('/purchasing/compare') >= 0 &&
                _array.indexOf(_url) < 0 &&
                _array.indexOf('list.asp') < 0){

                _array.push(_url);
            }
        });

        // cb(_array);

        return _array;
    },
    getDomHtmlSelect = function getDomHtmlLinks( $select) {
        var _array = [];

        $select.find('option').each(function(_index, _item){
            var obj = {};
            obj.index = _index;
            obj.text = $(_item).text();
            obj.value = $(_item).attr('value');

            _array.push(obj);
        });

        return _array;
    },
    getDomHtmlForm = function getDomHtml(options, cb) {
        options = options || { url: '', method:'POST', encoding: 'binary'};

        request( options, function (error, response) {
            if (!error && response.statusCode === 200) {
                var _buf = iconv.encode( response.body, 'binary'),
                    _html = iconv.decode( _buf, 'big5');
                $ = cheerio.load(_html);

                var tmpArray = url.split('/'),
                    fn = tmpArray[tmpArray.length-1].split('.')[0];

                savefile(new Date().getTime()+'_'+fn, _html);

                cb($);
            }else{
                console.log('error = ', error);
                console.log('options = ', options);
                // console.log('response = ', response);
            }

        });
    },
    getFile = function getFile( path, cb) {
        fs.readFile( path, function(err, data) {
            if(err){
                console.log('err = ', err);
            }else{
                cb(data);
            }
        });
    },
    getFileHtml = function getFilegetFileHtml( path, cb) {
        fs.readFile( path, function(err, data) {
            if(err){
                console.log('err = ', err);
            }else{
                $ = cheerio.load(data);
                cb($);
            }
        });
    },
    savefile = function savefile( name, data) {
        fs.writeFile( name+'.html', data, function(err) {
            if(!err){
                console.log('saved file '+name+'.html');
            }else{
                console.log('err = ', err);
            }
        });
    };

/**
    parse list.asp page
*/
// getFileHtml('./1371958421728.html', function($data){
//     console.log('getDomHtmlLinks() = ', getDomHtmlLinks($data));
//     var _links = getDomHtmlLinks($data);
//     for(var i = 0; i < _links.length; i++){
//         var _url = baseURL + _links[i].replace(/..\//ig, '');
//         getDomHtml( _url, function($){
//             console.log(i, ' --> ', _links[i]);
//         });
//     }
// });


/**
    parse FAN.html

    form type:
        S1:
        subtype:
        sizecode:
    form url:
        '/purchasing/compare/fan.asp'

    吊電扇規格(56)
    60, 90, 120, 130, 140, 150

    立地電扇規格(55)
    30, 35, 40, 50, 60

    桌上電扇規格(57)
    18, 20, 23, 25, 30, 35, 40

    自動旋選吊電扇(54)
    30, 40
*/

var fanObj = [
    {
        S1: 56, subtype: 60
    },
    {
        S1: 56,
        subtype: 90
    },
    {
        S1: 56,
        subtype: 120
    },
    {
        S1: 56,
        subtype: 130
    },
    {
        S1: 56,
        subtype: 140
    },
    {
        S1: 56,
        subtype: 150
    },
    {
        S1: 55,
        subtype: 30
    },
    {
        S1: 55,
        subtype: 35
    },
    {
        S1: 55,
        subtype: 40
    },
    {
        S1: 55,
        subtype: 50
    },
    {
        S1: 55,
        subtype: 60
    },
    {
        S1: 57,
        subtype: 18
    },
    {
        S1: 57,
        subtype: 20
    },
    {
        S1: 57,
        subtype: 23
    },
    {
        S1: 57,
        subtype: 25
    },
    {
        S1: 57,
        subtype: 30
    },
    {
        S1: 57,
        subtype: 35
    },
    {
        S1: 57,
        subtype: 40
    },
    {
        S1: 54,
        subtype: 30
    },
    {
        S1: 54,
        subtype: 40
    }
];

getFileHtml('./1371999790466_fan.html', function($){
    console.log($.html());
// getDomHtmlForm({
//     url: url,
//     method: 'POST',
//     encoding: 'binary'
// }, function($))
//         request( {
//             url: url,
//             encoding: 'binary'
//         }, function (error, response) {
//             if (!error && response.statusCode === 200) {
//                 var _buf = iconv.encode( response.body, 'binary'),
//                     _html = iconv.decode( _buf, 'big5');
//                 $ = cheerio.load(_html);

//                 var tmpArray = url.split('/'),
//                     fn = tmpArray[tmpArray.length-1].split('.')[0];

//                 savefile(new Date().getTime()+'_'+fn, _html);

//                 cb($);
//             }else{
//                 console.log('error = ', error);
//                 console.log('url = ', url);
//                 // console.log('response = ', response);
//             }

//         });
    // $('form').each(function(index, item){
    //     console.log(index, '+', $(item).attr('action'), $(item).attr('method'));

        // $(item).find('select').each(function(index, item){
        //     console.log($(this).attr('name'));
        //     $(item).find('option').each(function(index, item){
        //         console.log('option item', $(item).attr('value'), $(item).text());
        //     });
        // });

        // $(item).find('input').each(function(index, item){
        //     console.log($(this).attr('name'));
        //     console.log('input item', $(item).attr('name'), $(item).attr('onclick'));
        // });
    // });

});



// fs.readFile( './header.txt', function(err, data) {
//     if(!err){
//         data = data.toString('utf8');
//         $ = cheerio.load(data);

//         $('tr td').each(function(index, item) {
//             console.log($(item).text()+', ');
//         });

//     }else{
//         console.log('err = ', err);
//     }

//     // fs.writeFile( outputFileName, JSON.stringify(output, null, 4), function(err) {
//     //     if(!err){

//     //     }
//     // });
// });

// var savefile = function savefile( _fn){
//     var _header = '廠牌名稱, 型號, 產品型式, 規格, 消耗電力(W), 總風量, 效率值, 年耗電量(KWH), 年節電度數(KWH)(與同等級非標章機種比較), 省電金額(元)(與同等級非標章機種比較), 減低二氧化碳量(kg)(與同等級非標章機種比較), 尺寸',
//         _sizeName = _fn.replace(/.\//, '').replace(/.txt/, ''),
//         output = '';

//     output += _header+'\n';

//     fs.readFile( _fn, function(err, data) {
//         $ = cheerio.load( data.toString('utf8'));

//         $('tr').each(function(index, item) {
//             var _array = [];
//             for(var i = 0; i < item.children.length; i++){
//                 $item = $(item.children[i]);
//                 _array.push($item.text());
//                 // console.log('$item = ', $item.text());
//             }

//             _array.push(_sizeName);
//             output += _array.join(',')+'\n';
//         });


//         fs.writeFile( _sizeName+'.csv', output, function(err) {
//             if(!err){
//                 console.log('saved file ', _fn);
//             }
//         });
//     });
// };

// for(var i in inputFiles){
//     var _fn = inputFiles[i];

//     savefile(_fn);
// }