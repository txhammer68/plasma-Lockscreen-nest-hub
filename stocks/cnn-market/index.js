const scrapeIt = require("scrape-it")
const { map } = require("lodash/fp")
const fs = require('fs')

// Constants
const url                  = "http://money.cnn.com/data/markets/"
const url2                 = "https://money.cnn.com/data/commodities/index.html"
const col                  = "div.column.double-column > div.column.left-column > "
const col2                 = "div.column.double-column > div.column.left-column > "
const wm                   = "> a > span.world-market-"

// Selector Functions
const points               = i => name => "li:nth-child(" + i + ") span.ticker-" + name
const [dow, nasdaq, sp500] = map(points, [1,2,3])
const nth                  = i => "div:nth-child(" + i + ") "
const london               = i => col + nth(3) + "> div > " + nth(2) + "> " + nth(1) + wm + i
const hk                   = i => col + nth(3) + "> div > " + nth(1) + nth(2) + wm + i
const germany              = i => nth(3) + "> div > " + nth(2) + "> " + nth(2) + wm + i
const japan                = i => nth(1) + nth(1) + nth(1) + "span.world-market-" + i
const yield10              = i => col + nth(2) + "> ul > li:nth-child(1) > a > span.column.quote-" + i
const keyStats             = (n, i) => col + nth(2) + "> ul > li:nth-child(" + i + ") > a > span.column.quote-" + n
const keyStats2            = (n, i) => col + nth(2) + "> ul > li:nth-child(" + i + ") > a > span.column.commBotRow" + n
// console.log(keyStats2('col',5))

const selector = {
    dow            : dow      ('points'),
    dowChgPcnt     : dow      ('name-change'),
    dowChg         : dow      ('points-change'),
    nasdaq         : nasdaq   ('points'),
    nasdaqChgPcnt  : nasdaq   ('name-change'),
    nasdaqChg      : nasdaq   ('points-change'),
    sp500          : sp500    ('points'),
    sp500ChgPcnt   : sp500    ('name-change'),
    sp500Chg       : sp500    ('points-change'),
    japan          : japan    ('change-last'),
    japanChgPcnt   : japan    ('change-percent'),
    japanChg       : japan    ('change'),
    hk             : hk       ('change-last'),
    hkChgPcnt      : hk       ('change-percent'),
    hkChg          : hk       ('change'),
    london         : london   ('change-last'),
    londonChgPcnt  : london   ('change-percent'),
    londonChg      : london   ('change'),
    germany        : germany  ('change-last'),
    germanyChgPcnt : germany  ('change-percent'),
    germanyChg     : germany  ('change'),
    yield10Y       : keyStats ('col', 1),
    yield10YChg    : keyStats ('change', 1),
    oil            : keyStats ('col', 2),
    oilChg         : keyStats ('change', 2),
    gold           : keyStats ('col', 5),
    goldChg        : keyStats ('change', 5)
}   

const cnnMarket = async () => {
    const d = (await (scrapeIt(url, selector))).data
    var dow_up=true
    var nasdaq_up=true
    var sp500_up=true
    var oil_up=true
    var gold_up=true
    var y10_up=true
    nfObject = new Intl.NumberFormat('en-US')
    d.dow = d.dow.replace(/[^\d\.\-]/g, "");  
    nfObject.format(d.dow)
    d.dow=Math.round(d.dow)
    d.nasdaq = d.nasdaq.replace(/[^\d\.\-]/g, "");  
    nfObject.format(d.nasdaq)
    d.nasdaq=Math.round(d.nasdaq)
    d.sp500 = d.sp500.replace(/[^\d\.\-]/g, "");  
    nfObject.format(d.sp500)
    d.sp500=Math.round(d.sp500)
    nfObject.format(d.oil)
    d.oil = d.oil.replace(/[^\d\.\-]/g, "");  
    nfObject.format(d.gold)
    d.gold = d.gold.replace(/[^\d\.\-]/g, "");  
    nfObject.format(d.yield10y)
    d.yield10Y = d.yield10Y.replace(/[^\d\.\-]/g, "");  
    d.dowChg=nfObject.format(Math.round(d.dowChg))
    d.dowChg=(d.dowChg<=0?"":"+") + d.dowChg
    d.nasdaqChg=nfObject.format(Math.round(d.nasdaqChg))
    d.nasdaqChg=(d.nasdaqChg<=0?"":"+") + d.nasdaqChg
    d.sp500Chg=nfObject.format(Math.round(d.sp500Chg))
    d.sp500Chg=(d.sp500Chg<=0?"":"+") + d.sp500Chg
    var dow1 = (nfObject.format(d.dow) + "   "+d.dowChg)
    var nasdaq1 = (nfObject.format(d.nasdaq)+"   "+d.nasdaqChg)
    var sp1 = (nfObject.format(d.sp500)+"   "+d.sp500Chg)
    d.oilChg=nfObject.format(Math.round(d.oilChg))
    var oilChg=Math.round(d.oilChg*d.oil)/100  // convert from percent to actual change
    oilChg=(oilChg<=0?"":"+") + oilChg
    var goldChg=Math.round(d.goldChg*d.gold)/100
    goldChg=(goldChg<=0?"":"+") + goldChg
    d.yield10YChg=nfObject.format(d.yield10YChg)
    d.yield10YChg=(d.yield10YChg<0?"":"+") + d.yield10YChg
    var oil1="$"+d.oil+ "  "+ oilChg
    d.goldChg=(d.goldChg<=0?"":"+") + d.goldChg
    var gold1="$"+d.gold+ "  "+goldChg
    var yield1=d.yield10Y+"%  "+d.yield10YChg
    console.log(oil1)
        
    if (Math.sign(d.dowChg)==-1) { 
        dow_up="false"
        }
        else {dow_up="true"}
   
   if (Math.sign(d.nasdaqChg)==-1) { 
        nasdaq_up="false" }
        else {nasdaq_up="true"}
        
    if (Math.sign(d.sp500Chg)==-1) { 
        sp500_up="false" }
        else {sp500_up="true"}
        
    if (Math.sign(d.oilChg)==-1) { 
        oil_up="false"}
        else {oil_up="true"}
        
    if (Math.sign(d.goldChg)==-1) { 
        gold_up="false"}
        else {gold_up="true"}
        
    if (Math.sign(d.yield10YChg)==-1) { 
        y10_up="false" }
        else {y10_up="true"}
   
        let t1 = `var dow  = \x22`
        let t2 = dow1
        let t3 = `\nvar nasdaq  = \x22`
        let t4 = nasdaq1
        let t5 = `  |  \x22`
        let t6 = `\nvar sp500  = \x22`
        let t7 = sp1
        let t8 = `\nvar oil  = \x22`
        let t9 = oil1
        let t10 = `\nvar gold  = \x22`
        let t11 = gold1
        let t12 = `\x22`
        let t13 = `\nvar yield10  = \x22`
        let t14 = yield1
                
        let t1a = `\nvar dow_up  =`
        let t2b=dow_up
        
        let t15 = `\nvar nasdaq_up  = `
        let t16 = nasdaq_up
        
        let t17 = `\nvar sp500_up  =`
        let t18 = sp500_up
        
        let t19 = `\nvar oil_up  =`
        let t20 = oil_up
        
        let t21 = `\nvar gold_up  =`
        let t22 = gold_up
        
        let t23 = `\nvar y10_up  =`
        let t24 = y10_up
                
var fd = fs.openSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`, "w");

fs.writeFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t1, function (err) {
  if (err) throw err;
});

fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t2+`\x22`, function (err) {
  if (err) throw err;
});

fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t1a, function (err) {
  if (err) throw err;
});   

fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t2b, function (err) {
  if (err) throw err;
});
fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t15, function (err) {
  if (err) throw err;
});   
fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t16, function (err) {
  if (err) throw err;
});  


fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t17, function (err) {
  if (err) throw err;
});   
fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t18, function (err) {
  if (err) throw err;
});  

fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t19, function (err) {
  if (err) throw err;
});   
fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t20, function (err) {
  if (err) throw err;
});  

fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t21, function (err) {
  if (err) throw err;
});   
fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t22, function (err) {
  if (err) throw err;
});  

fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t23, function (err) {
  if (err) throw err;
});   
fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t24, function (err) {
  if (err) throw err;
});  

    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t3, function (err) {
  if (err) throw err;
});    
    fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t4+`\x22`, function (err) {
  if (err) throw err;
});

        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t6, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t7, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t12, function (err) {
  if (err) throw err;
});    
         fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t8, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t9+`\x22`, function (err) {
  if (err) throw err;
});    
         fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t10, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t11+`\x22`, function (err) {
  if (err) throw err;
});    
fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t13, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t14, function (err) {
  if (err) throw err;
});    
        fs.appendFileSync(`/home/hammer/.local/share/plasma/look-and-feel/DigiTech/contents/code/market.js`,t12, function (err) {
  if (err) throw err;
});    

fs.closeSync( fd )
   
    return  [
        { symbol: "DOW",      value: d.dow,      change: d.dowChg,     changePcnt: d.dowChgPcnt      },
        { symbol: "NASDAQ",   value: d.nasdaq,   change: d.nasdaqChg,  changePcnt: d.nasdaqChgPcnt   },
        { symbol: "S&P500",   value: d.sp500,    change: d.sp500Chg,   changePcnt: d.sp500ChgPcnt    },
        { symbol: "Japan",    value: d.japan,    change: d.japanChg,   changePcnt: d.japanChgPcnt    },
        { symbol: "HongKong", value: d.hk,       change: d.hkChg,      changePcnt: d.hkChgPcnt       },
        { symbol: "London",   value: d.london,   change: d.londonChg,  changePcnt: d.londonChgPcnt   },
        { symbol: "Germany",  value: d.germany,  change: d.germanyChg, changePcnt: d.germanyChgPcnt  },
        { symbol: "Yield10y", value: d.yield10Y, change: d.yield10YChg                               },
        { symbol: "Oil",      value: d.oil,      change: d.oilChg                                    },
        { symbol: "Gold",     value: d.gold,     change: d.goldChg                                   },
    ]     
}


module.exports = {
    cnnMarket
}

