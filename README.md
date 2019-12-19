# 台灣 EPUB 3 製作指引

## 關於本指引

### 目的

本製作指引（以下稱本指引）主要提供給出版社在製作一般EPUB格式電子書時作為參考使用。

由於EPUB 3格式有著相當多元的製作方式與表現手法。結果在製作時難以決定該使用何種方法，也不容易掌握其表現程度。以此，本指引作為一份中介規格書，提供出版社製作時參考使用，以解決這些問題。

同時，本指引不僅用於EPUB 3格式電子書製作使用，也提供電子書平台業者於製作EPUB 3閱讀程式時，作為一個須支援的技術規格說明，以求出版社所製作出的電子書得以在不同閱讀程式上有近乎一致的表現，達到一源多用的目的。

### 概要

本指引適用的書籍種類為：小說等文字書（Reflowable），以及漫畫、雜誌等圖文書（Fixed-Layout）。

文字書僅提供簡單體裁，不包含如文字方向混合（直排與橫排混合）以及多欄排版、文繞圖等具有特殊設計表現。部分進階的表現會在本指引中標註為「選擇性」，閱讀程式開發商可嘗試實作，出版社使用這些表現時需注意可能無法正常顯示。

圖文書僅限於漫畫，或者難以重製的雜誌，使用一頁一圖包裝成EPUB 3固定版面格式（簡易型Fixed-Layout）。使用HTML排版，或者加入MediaOverlay語音朗讀功能的複雜固定版面不是本指引的對象。

EPUB 3內使用HTML5與CSS3等網頁技術，各作業系統與瀏覽器組版引擎對於基本元素的解釋有相當的差異，這是發生在網頁上的既有現象，且電子書閱讀程式多半不會提供規格說明；也不一定提出測試方法讓出版社得以確認表現。為求單一檔案在不同閱讀器上能夠顯示一致，也是本指引的目的。

本指引以日本電子書出版社協會（電書協）公佈之EPUB 3 File Creation Guide為底本進行擴展，加入台灣數位出版產業之需求與特性。該範本在日本已經成為出版社與販售平台溝通的良好範例，並且具備文字直排等細節，且基於IDPF下Readium Foundation所公布的Readium程式作為基礎，提供範本與樣式表，為電子書表現的最大公約數。足以供中文電子書所使用。

我們也希望本指引提供的範本能夠適用至各種電子書製作軟體，令產製出的EPUB 3文件能夠具備通用性。令電子書的生產到販賣過程能夠更加順暢。

最終希望海內外各販售平台在提供閱讀程式時，能夠滿足本指引中的各項需求，以能夠完整呈現出版社所製作出的EPUB 3電子書，減少針對不同平台修改、調整的麻煩，降低書檔流通的障礙，讓電子書流通更為穩定確實。

本指引依照IDPF所公布的EPUB 3.01規範為基礎，並且EPUB 3.1規範。規範中未普遍實作，但為出版社重要需求的部分以附件提出，希望能取得海內外閱讀程式開發商的共識，作為添補修正。


## 檔案說明

此儲存庫中存放包含「台灣 EPUB 3 製作指引」之本文內容（Markdown 與 EPUB 格式），並針對文中所提及之設計規範與建議，提供 CSS 設計樣版以利電子書製作與閱讀器實作者參考。

### 範本全文

- [Markdown 格式](https://github.com/dpublishing/epub3guide/blob/master/tdpf-epub3guide.md)
- [EPUB 格式](https://github.com/dpublishing/epub3guide/tree/master/tdpf-epub3guide)

### 參考範例

- [CSS 樣版](https://github.com/dpublishing/epub3guide/tree/master/samples/style_template)
- 樣式參考範本
	- [Fixed Layout](https://github.com/dpublishing/epub3guide/blob/master/samples/EPUB%20FXL%20sample)
	- [Reflow 直排](https://github.com/dpublishing/epub3guide/blob/master/samples/EPUB%20reflow%20sample_%E7%9B%B4%E6%8E%92)
	- [Reflow 橫排](https://github.com/dpublishing/epub3guide/blob/master/samples/EPUB%20reflow%20sample_%E6%A9%AB%E6%8E%92)


### EPUB 3 實作案例參考

除了本指引所提供之上述參考範例外，另外也針對出版者常見的製作情境與需求，台灣數位出版聯盟亦使用公共版權與開放授權內容，提供以下貼近實際出版需求的實作案例。實作案例除使用本指引之參考 CSS 樣版外，也包含部分超出指引範圍但具實用性的效果應用展示。針對超出指引範圍之內容，出版者需自行測試不同平台、閱讀器之呈現相容性。

1. [橫排文字書：巴黎茶花女遺事](https://github.com/dpublishing/epub3guide/tree/master/practices/01_Reflow_Text_Horizontal)
	採民國初年林紓、王壽昌所翻譯之小仲馬作品《茶花女》，封面為穆夏所繪製的畫作。
	內容為橫排的文字書，主要說明了標題與段落語法，對齊方式、字體指定、強調與連結、行距與間距等基本排版元素。
	
2. [直排文字書：羅生門](https://github.com/dpublishing/epub3guide/tree/master/practices/02_Reflow_Text_Vertical)
	採民國初年魯迅所翻譯之芥川龍之介作品《羅生門》，封面為以 CC BY-SA 2.0 授權的攝影作品。
	內容為直排的文字書，主要說明了指定直排的方式，指定語言的方式，標點符號的使用方式以及直排特有縱中橫排、轉向的作法，也補充了行頭凸排與段落縮排與提排的指定方式。
	
3. [文字書嵌入字體：航海家金唱片](https://github.com/dpublishing/epub3guide/tree/master/practices/03_Embed_Fonts_And_Ruby)
	採美國太空總署置放到航海者一號太空船內金屬唱片中的各國問候語句，封面為公共領域的照片。
	內容為使用嵌入字體排列的中文注音符號、台語注音符號與泰文，主要說明如何標注注音符號，並且套用嵌入字體、調整排版達到最適宜的顯示效果。以及如何取得開放授權的字體嵌入 EPUB 中使用，以避免發生缺字的狀況。
	
4. [文字書註解與圖表：全球報業營運趨勢與產業現況](https://github.com/dpublishing/epub3guide/tree/master/practices/04_Image_Table_And_Footnote)
	採開放授權書籍《新聞業的危機與重建》第一章，取得作者戴伊筠同意授權使用，封面為公共領域的照片。
	內容為論文，有大量圖表，故本書使用了 EPUB 中的圖片一覽與表格一覽目錄。同時也說明表格與圖片的呈現與對齊方式，以及連結、註釋結構與樣式的調整。
	
5. [文字書圖文混排：阿麗思漫遊奇境記](https://github.com/dpublishing/epub3guide/tree/master/practices/05_Wrap_Text_Around_Image)
	採民國初年趙元任所翻譯之路易斯卡洛爾作品《Alice in wonderland》，封面為採 CC0 授權的插畫作品，內頁插畫為公共領域作品。
	內容為圖文混排，用以說明如何指定圖片尺寸與限制最大尺寸，並且配合實驗性的文繞圖排版。以及如何使用對齊、圖片邊界與框線來修飾。
	
6. [固定版型圖文書：清明上河圖](https://github.com/dpublishing/epub3guide/tree/master/practices/06_Fixed_Layout_Image)
	採故宮開放資料之清院本清明上河圖。
	內容為基本的固定版型圖文書，可供製作漫畫、雜誌與排版複雜的圖書參考。
	
7. [重排式文字書與固定版型圖文書混排：詩經](https://github.com/dpublishing/epub3guide/tree/master/practices/07_Reflow_FXL_Mixed)
	採《詩經》國風・周南兩則，配合國家圖書館所藏善本《詩經圖譜慧解》第二冊之版畫。
	內容為重排式文字與固定版型整頁圖片內容混合排列。用以說明如何在文字書中插入整頁圖片，或連續整頁圖片，例如書中連續照片、漫畫與跨頁圖片等。
	
8. [圖文影音書：仲夏夜之夢簡介](https://github.com/dpublishing/epub3guide/tree/master/practices/08_Audio_Video)
	採維基百科上對莎士比亞戲劇「仲夏夜之夢」的簡介，並且加上開放授權與公共領域的影片與聲音檔。
	內容使用了固定版面HTML排版，可供製作多媒體圖文書時參考使用。
	
9. [圖文朗讀書：水調歌頭](https://github.com/dpublishing/epub3guide/tree/master/practices/09_Media_Overlay)
	採蘇軾水調歌頭，錄音檔為開放授權使用之音檔，封面為故宮開放資料。
	內容使用了EPUB 3 Media Overlay朗讀功能，可供繪本等製作時參考使用。Media Overlay雖為EPUB 3的標準功能，但並非所有閱讀程式都支援。
	
10. [實驗性 RWD 設計：貧賤夫妻](https://github.com/dpublishing/epub3guide/tree/master/practices/10_RWD_Experimental)
	採鍾理和作品《貧賤夫妻》，封面為行政院客家委員會開放授權的美濃老照片。
	內容使用了幾項實驗性功能，一是軟換頁功能，二是 RWD 響應式設計，讓書的排版可以按照螢幕尺寸大小進行調整。但不見得能夠應用在所有電子書閱讀程式上。


### 產生 EPUB 封裝檔

為利於內容編修與版本管控，所有 EPUB 內容均以未封裝原始檔之方式存放。可使用 EPUBCheck 指令將本儲存庫中提供之 EPUB 原始內容產生為封裝後的 EPUB 檔案。關於更多 EPUBCheck 資訊可參考 EPUBChecker 官網。

1. 下載 EPUBCheck，並安裝 Java 相依元件。下載網址： https://github.com/w3c/epubcheck/releases

2. 執行 EPUBCheck，指定 EPUB 原始檔路徑進行內容檢查與封裝。以下指令以 EPUBCheck 4.2.2 為例，請自行更換範例中 `epubcheck.jar` 路徑。
  
   - 指令格式
   
     ```shell
     java -jar [指向epubcheck.jar路徑] [EPUB內容路徑] -mode exp -save
     ```
   
    - 指令範例
   
      ```shell
      java -jar /epubcheck-4.2.2/epubcheck.jar ./practices/01_Reflow_Text_Horizontal -mode exp -save
      ```

3. 如需一次產生本指引所有範本與案例之 EPUB 檔案，可參考 `pack-all.sh` 之 shellscript 指令碼自行修改。
