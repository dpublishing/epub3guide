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

此儲存庫中存放包含「台灣 EPUB 3 製作指引」之本文內容（Markdown 與 EPUB 格式），並針對文中所提及之設計規範與建議，提供 CSS 設計樣版以利電子書製作與閱讀器實作者參考。為利於內容編修與版本管控，所有 EPUB 內容均以解壓縮後之原始檔方式存放。

### 範本全文

- [Markdown 格式](https://github.com/dpublishing/epub3guide/blob/master/tdpf-epub3guide.md)
- [EPUB 格式](https://github.com/dpublishing/epub3guide/blob/master/samples/%E5%8F%B0%E7%81%A3EPUB%203%E8%A3%BD%E4%BD%9C%E6%8C%87%E5%BC%95)

### 參考範例

- [CSS 樣版](https://github.com/dpublishing/epub3guide/tree/master/samples/style_template)
- 指引範本
	- [Fixed Layout](https://github.com/dpublishing/epub3guide/blob/master/samples/EPUB%20FXL%20sample)
	- [Reflow 直排](https://github.com/dpublishing/epub3guide/blob/master/samples/EPUB%20reflow%20sample_%E7%9B%B4%E6%8E%92)
	- [Reflow 橫排](https://github.com/dpublishing/epub3guide/blob/master/samples/EPUB%20reflow%20sample_%E6%A9%AB%E6%8E%92)

### 產生 EPUB 檔方式

可使用 EPUBChecker 指令將本儲存庫中提供之 EPUB 原始內容產生為封裝後的 EPUB 檔案。關於更多 EPUBChecker 資訊可參考 EPUBChecker 官網： https://github.com/w3c/epubcheck 。

```shell
epubcheck [目錄名稱] --mode exp --save
```