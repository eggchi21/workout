$(function(){
/**
 * ---------------------------------------
 * This demo was created using amCharts 4.
 *
 * For more information visit:
 * https://www.amcharts.com/
 *
 * Documentation is available at:
 * https://www.amcharts.com/docs/v4/
 * ---------------------------------------
 */

// Themes begin
am4core.useTheme(am4themes_material);
am4core.useTheme(am4themes_animated);
// Themes end


var chart = am4core.create("chartdiv", am4plugins_wordCloud.WordCloud);
var series = chart.series.push(new am4plugins_wordCloud.WordCloudSeries());

series.accuracy = 4;
series.step = 15;
series.rotationThreshold = 0.7;
series.maxCount = 200;
series.minWordLength = 2;
series.labels.template.margin(4,4,4,4);
series.maxFontSize = am4core.percent(30);

series.text = "BCAA EAA アウターマッスル アスタキサンチン アナボリック アブローラー アンチエイジング インナーマッスル ウェイトトレーニング ウエストニッパー エアロバイク カーフレイズ カーボ カタボリック カロリー クランチ グルテンフリーダイエット クレアチン ケトジェニックダイエット コレステロール サーキットトレーニング サイドレイズ ササミ サプリ ショルダープレス スクワット ダンベル ダンベルカール ダンベルトライセップス チンニング ツイストクランチ デッドリフト デトックス ノンカロリー バーディップ バーベルカール バーベルトライセップス バターコーヒーダイエット バナナダイエット ハムストリング ヒップリフト フィジーク プロテイン ベンチプレス ベントオーバーローイング ボディビル マイクロダイエット マシーントレーニング ヨガ ラットプルダウン リバウンド レッグレイズ ロハスダイエット ワンハンドロウ"

series.colors = new am4core.ColorSet();
series.colors.passOptions = {}; // makes it loop

//series.labelsContainer.rotation = 45;
series.angles = [0,-90];
series.fontWeight = "700"

setInterval(function () {
  series.dataItems.getIndex(Math.round(Math.random() * (series.dataItems.length - 1))).setValue("value", Math.round(Math.random() * 10));
 }, 10000)
})