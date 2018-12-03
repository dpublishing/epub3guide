# 台灣EPUB 3製作指引

> 版本資訊：1.0
> 發布日期：2018/12/04
> 發布位址：https://github.com/dpublishing/epub3guide

## 關於本文件

### 目的

本規格書（以下稱本文件）主要提供給出版社在製作一般EPUB格式電子書時作為參考使用。

由於EPUB 3格式有著相當多元的製作方式與表現手法。結果在製作時難以決定該使用何種方法，也不容易掌握其表現程度。以此，本文件作為一份中介規格書，提供出版社製作時參考使用，以解決這些問題。

同時本文件不僅用於EPUB 3格式電子書製作使用，也提供販售平台製作EPUB 3閱讀程式時須考量支援的技術規格，以求出版社所製作出的電子書得以在不同閱讀程式上有近乎一致的表現，達到一源多用的目的。

### 概要

本文件適用的書籍種類為：小說等文字書，以及漫畫、雜誌等圖文書。

文字書僅提供簡單體裁，不包含如文字方向混合（直排與橫排混合）以及多欄排版、文繞圖等具有特殊設計表現。部分進階的表現會在本文件中標註為「選擇性」，閱讀程式開發商可嘗試實作，出版社使用這些表現時需注意可能無法正常顯示。

圖文書僅限於漫畫，或者難以重置的雜誌，使用一頁一圖包裝成EPUB 3固定版面格式。使用HTML排版，或者加入MediaOverlay語音朗讀功能的複雜固定版面不是本文件的對象。

EPUB 3內使用HTML5與CSS3等網頁技術，各作業系統與瀏覽器組版引擎對於基本元素的解釋有相當的差異，這是發生在網頁上的既有現象，且電子書閱讀程式多半不會提供規格說明；也不一定提出測試方法讓出版社得以確認表現。為求單一檔案在不同閱讀器上能夠顯示一致，也是本文件的目的。

本文件以日本電子書籍出版社協會（電書協）公佈之EPUB 3 Authoring Guide為底本，該範本在日本已經成為出版社與販售平台溝通的良好範例，並且具備文字直排等細節，且基於IDPF下Readium Foundation所公布的Readium程式作為基礎，提供範本與樣式表，為電子書表現的最大公約數。足以供中文電子書所使用。

我們也希望本文件提供的範本能夠適用至各種電子書製作軟體，令產製出的EPUB 3文件能夠具備通用性。令電子書的生產到販賣過程能夠更加順暢。

最終希望海內外各販售平台在提供閱讀程式時，能夠滿足本文件中的各項需求，以能夠完整呈現出版社所製作出的EPUB 3電子書，減少針對不同平台修改、調整的麻煩，降低書檔流通的障礙，讓電子書流通更為穩定確實。

本文件依照IDPF所公布的EPUB 3.01規範為基礎，並且參考制定中的EPUB 3.1規範，規範中未普遍實作，但為出版社重要需求的部分以附件提出，希望能取得海內外閱讀程式開發商的共識，作為添補修正。

### 需求層級

本文件之規格需求層級依照RFC 2119的定義如下：

* **必需（Must）**：必需支援。

* **需要（Should）**：若無特別原因必需支援。

* **不需（Should Not）**：若無特別原因不得支援。

* **不得（Must Not）**：不得支援。

* **推薦（Recommend）**：建議實做，但不予以保證。

### 範本檔案

依照本文件所製作的EPUB範本提供如下：

> TODO: 改為正式的 EPUB sample file URL

* [Fixed Layout 固定版面](https://這邊要放 LINK)

* [Reflow 文字書](https://這邊要放 LINK)

----



## 對閱讀程式的需求

本章節針對閱讀程式（Reading System, 以下稱為`RS`）的技術面進行說明。

EPUB 3內的各種內容，包括包裝文件、導覽文件、內容文件、樣式表等通稱為「文件檔案」。

### 文件檔案的基礎

#### <u>文字編碼</u>

文件檔案使用`UTF-8`編碼

不管是否有BOM（Byte Order Mark）都**需要**能夠解譯。

但本文件**建議**儲存為沒有BOM的文件。

#### <u>換行符號</u>

文件檔案中的換行代碼為`CR+LF`、`CR`與`LF`，無論使用哪一種都**需要**能夠正確解譯。

同一份文件檔案混用換行代碼時不在此限。

本文件**建議**同一份文件中不要混用不同的換行代碼。

#### <u>原始碼中的空白、換行與註解處理</u>

文件檔案中記述規則與及解譯以XHTML規則為依據。

適當忽略原始碼中的註解行、可任意配置元素中屬性的順序，各屬性間如果有一個以上的空白、換行或Tab等，請適當解譯，與支援Web標準的現代瀏覽器具備相同的嚴謹度與自由性。

### 包裝文件（Package Document/OPF檔案）

#### <u>遵守翻頁方向</u>

書的翻頁方向**必需**依從包裝文件中Spine元素的`page-progresson-direction`屬性，不管內容文件或者樣式表中使用哪一種`writing-mode`。

而XHTML內容文件中的文字排列方向，則依照各XHTML中Body元素所指定的`writing-mode`屬性。當`writing-mode`指定於html元素時，必需繼承於body元素。

例如`page-progression-direction`指定為`rtl`（由右向左）時，而xhtml的`writing-mode`指定為`horizontal-tb`（橫排）時，期待文字於螢幕內「由左向右」顯示，而新的頁面則是「由右向左」增加。

#### <u>遵守Spine元素指定規則</u>

**必需**正確依照spine元素內的順序顯示內容。

也**必需**反應itemref元素內`linear`屬性的`yes`與`no`。當為`no`時則**不應**顯示，當為`yes`時，則**不應**隱藏。

也**必需**反應itemref元素中「properties」屬性所指定的`page-spread-right`與`page-spread-left`。

未記載於spine元素中的內容，就**不應**作為書的內頁所顯示。

#### <u>不使用已廢止的元素</u>

guide元素已經廢止，故**不應**使用該語法。

#### <u>處理Metadata等</u>

當RS支援`<dc:title>`資訊時，會將所記載內容的書名使用於RS中顯示。

當RS支援`<dc:creator>`資訊時，會將所記載內容的作者名使用於RS中顯示。顯示多數作者時的顯示方式及其角色，則由各RS自行判斷處理。

當有多數作者時，出版社可自行決定要在一個`<dc:creator>`中記載全員，或者分開記載。當分開記載時，出版社**必需**給予該作者`role`的值，以及顯示順序。

作者名為中文時，不另外加入`file-as`，而以`<dc:creator>`中文姓氏首字筆順排列。

檔案id（unique-identifier）基本上**必需**使用`urn:isbn:xxxxxxxxxxxxx`（x為數字）標記，不需加入連字號；若無isbn，則使用uuid`urn:uuid:xxxxxxxx:xxxx:xxxx:xxxx:xxxxxxxxxxxx`（x為16進位）。

更新日期若沒特別指示，設定為製作預計的出版日；這項日期RS**不應**顯示。

### 導覽文件（EPUB Navigation Document）

#### <u>處理導覽文件</u>

當導覽文件與ncx檔案同時存在時，**必需**優先處理導覽文件；按照EPUB 3.1規格，製作時可不加入ncx檔案。

#### <u>顯示導覽文件</u>

導覽文件的顯示方式由RS自行決定，但至少**需**顯示三層級目錄。本規格預設導覽文件不會包含連結以外的元素。

### 基本樣式表

#### <u>CSS值的限制與實作基準</u>

依照現時點各瀏覽器引擎的CSS支援狀況，本文件提供製作時可通用的最底限CSS屬性。當遇到排版相關基礎屬性在不同RS上顯示不同時，主要以Readium為基準。當使用其他CSS屬性時，出版社理解支援的不一致，需自付責任。

#### <u>使用預設樣式表集</u>

本文件提供了基本樣式表集，主要希望在製作時能直接使用之中的各項Class。但也可以調整各CSS檔案，新增Class或者修改既有的Class名稱，或者在既有的Class中追加新的屬性。所以RS不可以直接使用樣式表集中的Class，而是透過這份樣式表了解所該支援的排版表現。

#### <u>不使用替代樣式表</u>

RS可以自行決定是否讓使用者自行切換直排或者橫排。

但RS實作時，建議考量到以下兩點：

* 預設使用作品檔案中，預先指定的排列方向顯示；

* 當切換到非作品檔案預先指定的排列方向顯示時，希望能在功能介紹或者常見問題中寫出可能會與作者以及製作者預設的表現形式有所不同。

現狀大多數RS不讓使用者自行切換排版方向，主要是實作切換替代樣式表的環境不多，也缺少檢查用的工具與指標。同時不依存排版方向設計的邏輯方向指定CSS（如margin-start）還尚未完善。使得要切換排版方向非常困難，依照狀況不同會花上相當的時間調整。

#### <u>盡量不使用-epub-Prefix的CSS屬性</u>

雖然在EPUB 3.0規範中為了解決相容性問題，而有制定許多以`-epub-`Prefix來額外處理的CSS屬性，但由於在EPUB 3.2版規範中捨棄了這些屬性，所以本文件不推薦使用`-epub-`Prefix的CSS數值。

而因為多數行動裝置作業系統使用Webkit作為核心，所以在不具Prefix的CSS屬性無法使用時，可以追加`-webkit-`以求相容。為求後續逐步調整變化，建議並列而非取代。

#### <u>使用@import規則</u>

為求讓各XHTML內連結CSS檔案的記載方式簡單一致，並且讓CSS能夠被客制化調整。本文件範本在XHTML內使用link元素讀取主要CSS，並且使用@import規則，在主要CSS檔案內部讀入所需的各CSS檔案。也就是RS需要實作讓XHTML讀入複數CSS的功能。

但不推薦在以@import讀入的CSS檔案中，再使用@import功能。

#### <u>需支援嵌入字體</u>

RS需支援嵌入字體。本文件建議將嵌入字體應用於中文、日文以外的語言，如韓文、泰文、越南文等常與中文混合排列的語言；若要使用中文、日文為嵌入字體，則需預先按照使用的文字製作成字體子集（subset）。

#### <u>指定html元素</u>

html元素內原則上除了排版方向（writing-mode）與全體字體指定（font-family）外，不指定其他值。以上兩者都應該繼承至body元素中。

### 覆蓋RS的預設樣式表

書籍檔案中的CSS應該覆蓋RS中原有的預設樣式表。若RS內已經有預設樣式表，推薦對出版社公開其規格。

### 文字與字體

#### <u>需包含的文字數量</u>

所使用的字型**必需**包含Unicode 1.0中日韓共同表意漢字共20,914字，**推薦**支援到Unicode 3.0包含Ext-A在內共27,496字。若RS需要在香港地區提供服務，則**必需**包含香港增補字符集HKSCS-2008的5,009字元。

英文與數字則**必需**包含Basic Latin與Latin-1 Supplement共256字元，其餘語言文字不需編碼，顯示其他文字時，RS需要使用其他語系的字型退回（Fallback）顯示。

#### <u>字體</u>

閱讀程式**必需**提供字型，以支援以下兩種字體

- 等寬的明體字型

- 等寬的黑體字型

**推薦**閱讀程式支援以下字體，以提供最佳排版表現

- 等寬的楷體字型

同時以上字型**必需**如下指定為「Generic font family」供書檔顯示對應

```css

.mfont        Serif             ：明體

.gfont        Sans-Serif        ：黑體

.kfont        Cursive           ：楷體

```

> 說明：每款RS所採用的字型不同，為避免出版社製作時需以窮舉方式指定個別字型名稱，RS需要預先做好CSS Generic family與使用字型的對應。EPUB中指定為serif的段落，會直接套用RS所提供的明體字。

當字型尺寸一致時，以上三字體的em尺寸**必需**相同。

當使用樣式表如text-orientation改變文字方向時，em尺寸**必需**保持不變。

三字體顯示上的寬度需要一致，不得有大幅度的差別，且中心線**必需**對齊。

當RS不提供楷體字型時，則**必需**將Cursive指定為黑體作為替代字型。

#### <u>直排時的文字方向</u>

字型規格上，**必需**依照Unicode Consortium所提供的文件UTR#50，將特定字碼於直排時轉向。

```

Unicode® Technical Report #50 UNICODE VERTICAL TEXT LAYOUT

http://unicode.org/reports/tr50/

```

> 說明：當出版社製作EPUB檔案時，標點符號會使用字型轉向功能自動轉向，所以**不得**使用直排字符，如﹁︽等。UTR#50涵蓋字元過多，故**必需**支援的符號如附件。

符合UTR#50定義的文字，在直排時須自動轉向，若需要手動轉向，RS必須支援以下兩種語法：

```css

直立：                  text-orientation: upright;

向右旋轉90度：          text-orientation: sideways;

```

> 說明：半形英文與數字採用upright轉正時，許多RS無法置放於文字中線上，這時可以採用-text-combine作為替代方案，但本CSS屬性主要是供英文數字組合轉正排列使用，請盡量避免。

#### <u>直排時的對齊</u>

圖片與直立文字，請依循CSS Writing Modes Level 3中`4.2 Text Baselines`的`central`排列，也就是置於文字的中線上。

```

CSS Writing Modes Level 3

http://www.w3.org/TR/2014/CR-css-writing-modes-3-20140320/#central-baseline

```

### 圖片

#### <u>圖片的種類</u>

**必需**能使用JPEG與PNG格式的圖片，**選擇**性支持GIF格式。

**必需**支援PNG的Alpha圖層，即能顯示透明色，若支援GIF，需比照支援。

圖片色彩須使用RGB，**不得**使用CMYK，推薦色域為sRGB。

#### <u>造字圖片</u>

透過本文件的圖片縮小語法，讓圖片顯示為內文一字尺寸。用於填補生罕字等內建字體不支援的漢字。不特別指定圖片尺寸極限，但提供推薦值：

```

圖片尺寸：128x128 px

圖片格式：8bit的白底PNG

反鋸齒：無

```

（補充：為對應各種閱讀程式的預設底色，以透明底色PNG較佳。但考量到現在多數閱讀程式有對應黑底白字的「夜間模式」，透明底色會讓圖片內容無法辨識，故推薦較為通用的白色底色）

#### <u>指定圖片與Block元素的尺寸以及最大尺寸</u>

目前各瀏覽器上max-height與max-width的動作有所不同。於RS上實作時，這兩個值應該以RS內內容可顯示範圍為基礎，顯示上請以Readium作為基準。

若內容檔案中指定的圖片尺寸大於可顯示範圍，RS應以最大顯示範圍為主，忽略所指定的圖片尺寸。內容檔案也盡量不要以絕對值來指定圖片尺寸。

圖片或block元素以及inline-block元素，是否需要換頁

文字行內元素要是大於行內預設要讓元素可顯示的空間時，RS需要將元素送到下一行或者下一頁。

不管是Block或者inline-block元素，在RS頁面內，讓元素顯示的空間比要顯示的元素小時，RS需要將元素送到下一頁。

#### <u>與頁面進行方向寬度相等或者小於寬度</u>

若元素無法放進顯示空間時，則於下一頁顯示該元素。當元素指定為與頁面等寬時，送到下一頁也需要與頁面等寬。

這時元素在非頁面進行方向那一端（直排時為高），在與頁面等寬的狀況下，超過螢幕內空間的話，則無法顯示。

> 說明：當在可顯示區域為高800x寬600px的RS中，一張寬600px的圖片設定寬度為width: 100%。而置放頁面已經有數行文字佔用顯示空間時，RS需要將該圖片送到下一頁，以寬度600px顯示。
>
> 但若該圖片高度為1000px時，則會有200px的空間受到切割而無法顯示。製作方應該不指定寬度為Width: 100%，改為height: 100%，讓寬度依比例自動調整。

#### <u>大於頁面進行方向時</u>

RS應縮放為與頁面等寬，即圖片不可跨頁切割顯示。

說明：當在可顯示區域為高800x寬600px的RS中，一張寬1000px的圖片設定寬度為width: 100%。RS則不可於單頁中顯示600PX，將剩餘400PX移到下一頁顯示。而應該調整寬度為600PX，高度自動依比例調整。

#### <u>縮小圖片，讓使用者操作放大</u>

透過指定圖片尺寸或者RS自動處理，使得圖片顯示比原來尺寸還要小時，推薦RS實作縮放功能，讓使用者能夠點擊圖片將圖片放大到原來尺寸。讓螢幕較小時，也能閱讀圖片中的文字。

### 封面圖片

#### <u>替代圖片</u>

書籍檔案中有時可能無法提供封面圖片，RS在沒有封面圖片的狀況下，需要提供於書櫃顯示用的替代圖片，使其能正常運作。

#### <u>檔案名稱</u>

封面圖片的檔案名，在出版社沒有特別指示的狀況下，為了讓RS能夠快速辨識，推薦使用共同名稱（cover.jpg/cover.png）。

### 頁面邊界

#### <u>Body元素的留白</u>

現狀多數RS都會自行加入無法調整的邊界留白。所以本文件範本的Body元素內，預設將margin與padding設定為0。也不推薦出版社進行調整。

#### <u>內文顯示區域內的邊界</u>

RS不應在body元素內部內容顯示空間加入自有的邊界。同時書籍檔案中所指定的margin與padding，空白行等，RS不應該自行調整處理。

例如在章節開頭加上無法刪除的邊界，或將指定的縮排與空白行等任意壓縮，都會影響到作者與製作者的設計，不應發生。

### 其他HTML元素

#### <u>空白行所使用的`<br/>`</u>

書籍中為了區分章節段落，會在段落之間加入空白行，可以使用`<br/>`處理為空白行。RS遇到`<br/>`或者`<br />`都須正確處理。請注意不得使用`<br>`，會不符合XHTML規則發生錯誤。

當用於段落間時，為求行距一致，推薦使用`<p><br/></p>`來確保空完整一行。

#### <u>注音符號使用的`<ruby>`</u>

目前注音符號的顯示還不能以Web技術完整達成。當注音出現在內文時，建議使用缺字圖片的方式製作。注於側旁的注音目前尚不能完美顯示。

#### <u>頁面內連結（錨點連結）</u>

點擊`<a href="檔名#錨點名">文字</a>`中指定的連結（若在同一檔案中，檔名可省略）時，需要跳到`<元素名 id="錨點名">`所在的元素位置。檔案名與錨點名於實際運用時，不應該使用全形文字與空白。

此外，跳到該元素時，該元素要顯示在第一行，或者預先演算出的頁面裡該元素所在頁，由各RS決定。

#### <u>註釋連結</u>

當頁面內連結用於註解時，則需按照EPUB的推薦語法製作，如：

``` html

<a epub:type="noteref” class="noteref" href="#註解編號" rel="footnote" >1</a>

<div epub:type="footnote" class="footnote" id="註解編號">

<p>注釋內容中的一個段落。</p>

</div>

```

若需讓讀者閱讀註解後回到內文定點，則可雙向設定錨點：

``` html

<a epub:type="noteref" class="noteref"  id="位置編號" href="#註解編號" rel="footnote" >1</a>

<div epub:type="footnote" class="footnote" id="註解編號">

<p>注釋內容中的一個段落。</p>

<a href="#位置編號">返回符號</a>

<div>

```

RS可以利用以上標準語法製作不同顯示方式，如跳出式註解，但應注意不得讓註解內元素無法顯示或受到裁切。但由於各RS支援程度不同，在製作時依然要保留以上語法。

#### <u>nav與列表元素</u>

列表雖然應該依循語意，使用ol, ul, li等元素標註，但由於需要透過樣式表調整位置，所以建議使用`<p>`元素取代。

導覽文件如EPUB Content Documents 3.0.1所記載，列表元素不應該顯示其編號。

### 表格

目前RS在處理HTML `<table>` 時，表現性尚未最佳化；在分頁與小尺寸螢幕上表現更不理想。若希望表格呈現與原書近似，建議將表格處理為白色底色PNG圖片（原因同缺字圖片）插入頁面中。

若要使用 `<table>` 來製作表格，請自行測試顯示效果。各RS間顯示結果不一定一致。

### 數學等計算公式

EPUB規範中雖推薦使用MathML來顯示計算公式，但現在各瀏覽器引擎對MathML顯示的支援狀況還過低，以至於許多使用瀏覽器進行電子書顯示的服務無法提供完善的資源。建議將計算公式處理為白色底色PNG圖片插入頁面中，並且按照所佔行數來指定高/寬度。

### 其他CSS的解釋方法

#### <u>書名號與私名號</u>

當要在內容加上私名號時，請使用CSS的text-decoration語法，橫排時值為underline，直排時值為overline，而標注書名號時，則應該加上`text-decoration: wavy`（目前需-webkit- prefix）。

目前瀏覽器處理連續出現的私名號與書名號時，線段不會分開。建議RS自行開發切割線斷的功能。

#### <u>縱中橫排</u>

使用CSS屬性`text-combine: horizontal;`與`text-combine-horizontal: all;`可以將直排文字中的半型英文與數字與符號轉橫。

縱中橫排的文字列必需壓縮視為一個文字，必要時可以突出一文字的寬度，延伸到行距間。

#### <u>不顯示</u>

必需正確處理`display: none`。

不想顯示給讀者看的內容最好不要包含在書籍檔案中，或者使用HTML註解方式予以隱藏。也推薦支援`visibility: hidden`，但本文件預設不使用JavaScript功能來切換CSS改變顯示狀態，所以應該不會使用到visibility，所以在範本中不使用該屬性。

### 標點符號

中文標點符號目前尚未有指定標準Unicode字碼的對應文件，這裡列舉出推薦使用的字碼，期許出版社與製作者在製作書籍檔案時使用。RS端必須保證以下字碼的正確顯示，同時也列出高頻率使用，須於直排中向右轉90度（透過字型功能達到）的標點符號。

| 標點名稱       | Unicode | 直排時轉90度 | 標點名稱       | Unicode | 直排時轉90度 |
| -------------- | ------- | ------------ | -------------- | ------- | ------------ |
| 逗號（，）     | U+FF0C  | 否           | 句號（。）     | U+3002  | 否           |
| 頓號（、）     | U+3001  | 否           | 冒號（：）     | U+FF1A  | 否           |
| 分號（；）     | U+FF1B  | 否           | 驚嘆號（！）   | U+FF01  | 否           |
| 問號（？）     | U+FF1F  | 否           | 間隔號（・）   | U+00B7  | 否           |
| 刪節號（……）   | U+2026  | 是           | 破折號（—）    | U+2014  | 是           |
| 分隔號（／）   | U+FF0F  | 否           | 連接號（～）   | U+FF5E  | 是           |
| 前引號（「）   | U+300C  | 是           | 後引號（」）   | U+300D  | 是           |
| 前雙引號（『） | U+300E  | 是           | 後雙引號（』） | U+300F  | 是           |
| 前括號（（）   | U+FF08  | 是           | 後括號（））   | U+FF09  | 是           |
| 前書名號（《） | U+300A  | 是           | 後書名號（》） | U+300B  | 是           |
| 前篇名號（〈） | U+3008  | 是           | 後篇名號（〉） | U+3009  | 是           |

破折號由兩個EM DASH（U+2014）構成，RS使用字體需要使用字體功能使其連結。若出版社希望在任何狀況下都讓破折號連結時，可以使用─ `U+2500 BOX DRAWINGS LIGHT HORIZONTAL`代替，RS也必需讓此符號於直排時向右轉90度。

刪節號U+2026在中文顯示時，無論橫排或直排，都應該為置於中央的三點符號，RS內建字體必需符合此規則。Unicode中近似的符號⋯ `U+22EF MIDLINE HORIZONTAL ELLIPSIS`由於在Android舊版系統上無法顯示，故不建議出版社使用。

間隔號U+00B7並非所有的字體都為全形符號，RS採用字體需要將其造為全形。間隔號也可使用・  `U+30FB KATAKANA MIDDLE DOT`，RS採用字體必需包含此字元。

此外，也推薦使用以下西文標點：

標點名稱 | Unicode | 直排時轉90度
------- | ------------ | --------
' 省略符號（Apostrophe） | U+0027 | 否
" 引號（Quotation Mark） | U+0022 | 否
“ 左引號（LEFT DOUBLE QUOTATION MARK） | U+201C | 否
” 右引號（RIGHT DOUBLE QUOTATION MARK） | U+201D | 否

### 固定版面EPUB

EPUB 3.0的固定版面分為兩種，一種為圖片為主，一種則是利用HTML、CSS與JavaScript等技術達到動態表現。由於能夠完整支援後者的RS數量不多，本文件僅止於使用圖片的前者。

使用圖片構成的固定版面，使用SVG Wrapping語法處理。將SVG語法直接記載於XHTML中，所能使用的圖片格式與文字重排（reflow）格式相同。頁面上的連結與目錄也使用SVG格式，在圖片經縮放後也能對應到對的位置。

除封面頁外，製作檔案時頁數必須成對。

只有封面頁（書籍檔案中第一頁）按照EPUB Fixed Layout語法，在spine中的itemref元素中指定為`properties="rendition:page-spread-center"`，以單頁呈現。封面只要不會影響到後續頁面的顯示順序，可以不需要置放於畫面的正中央。

### 其他

#### <u>Script</u>

書籍預設不使用JavaScript，但推薦RS能夠支援，出版社使用該功能時需要預先測試各RS的支援程度。

### RS需支援的HTML元素以及CSS屬性

#### <u>【HTML】</u>

##### 根元素

```html

html

```

##### 文件的metadata

```html

head / title / link / meta / style

```

##### 區塊元素

```html

body / h1~h6 / nav（預設僅使用在導覽文件中）

```

##### 內容群組化

```html

div / p / hr / ol與ul（預設僅使用在導覽文件中）/ li（預設僅使用在導覽文件中）

```

##### 為文字加入意義

```html

a / br / ruby / rt / span

```

##### 插入元素

```html

img / SVG（僅用於固定版面SVG Wrapping與ImageMap）

```

#### <u>【CSS】</u>

##### 値

```css

% / px / em / inherit / #RRGGBB / #RGB / rgb(R,G,B) / 色彩名（17色） / transparent

```

##### 選擇器

```css

Type Selector: ELEMENT

Universal Selector: *

Class Selector: .class

同時指定複数Class: class="class class class ..."

組合指定複数Class: .class.class

ID Selector: #id

```

##### 屬性選擇器

```css

[att] / [att="val"] / [att~="val"] / [att|="val"]

```

##### 關聯組合

```css

子孫Selector「A B」 / 子Selector「A > B」 / 兄弟Selector（隣接Selector）「A + B」 / 群組化「A, B」

```

##### 虛擬元素

```css

:link / :visited / :active / :hover（※僅用於能用滑鼠操作的RS）

!important 宣告

@規則

@charset / @font-face / @import / @media

```

##### 色彩、背景

```css

color / background（僅限色彩） / background-color

```

##### Margin

```css

margin / margin-top / margin-right / margin-bottom / margin-left

```

##### Padding

```css

padding / padding-top / padding-right / padding-bottom / padding-left

```

##### Border

```css

border / border-top / border-right / border-bottom / border-left

border-width / border-top-width / border-right-width / border-bottom-width / border-left-width

border-style / border-top-style / border-right-style / border-bottom-style / border-left-style

border-color / border-top-color / border-right-color / border-bottom-color / border-left-color

```

##### Font

```css

font / font-family / font-size / font-style / font-weight / line-height

```

##### Text

```

text-align / text-decoration / text-indent / letter-spacing / vertical-align / word-wrap

```

##### 寬與高

```css

width / height / max-width / max-height

```

##### 顯示

```css

display (display: block; / display: inline-block; / display: inline; / display: none;)

```

##### Paged Media

```css

page-break-before / page-break-after / page-break-inside

```

##### CSS Text Level 3

```css

line-break / word-break / text-align-last

```

##### CSS Writing Modes Module Level 3

```css

writing-mode / text-orientation / text-combine / text-combine-horizontal

```

##### CSS Fonts Level 3

```css

@font-face (font-family / font-style / font-weight / src / unicode-range)

```

##### CSS Text Decoration Level 3

```css

text-emphasis / text-emphasis-color / text-emphasis-style / text-underline-position / text-decoration-style

```

### RS不需支援的HTML元素與CSS屬性

#### 【HTML】

##### 文件的Metadata

```html

base

```

##### Scripting

```html

script / noscript

```

##### 區塊元素

```html

section / article / aside / header / footer / address

```

##### 內容群組化

```html

blockquote / ul / dl / dt / dd / figure / figcaption

```

##### 為文字加入意義

```html

em / strong / pre / subとsup / i / b / u / s / small / cite / q / dfn / abbr / time / code / var / samp / kbd / mark / bdi / bdo / wbr / rb / rtc / rp

```

##### 修正

```html

ins / del

```

##### 插入內容

```html

map / area / iframe / embed / object / param / video / audio / source / track  / canvas / MathML / SVG（固定版面以外）

```

##### 表格檔案

```html

table / caption / colgroup / col / tbody / thead / tfoot / tr / td / th

```

##### 表單

```html

form / fieldset / legend / label / input / button / select / datalist / optgroup / option / textarea / keygen / output / progress / meter

```

##### 互動元素

```html

details / summary / command / menu

```

#### 【CSS】

##### 値

```css

ex / in / cm / mm / pt / pc

```

##### 選擇器

```css

E:focus / E:lang(c) / E:first-child / E:first-line / E::first-line / E:first-letter / E::first-letter / E:before / E::before / E:after / E::after / E[foo^="bar"] / E[foo$="bar"] / E[foo*="bar"] / E:root / E:nth-child(n) / E:nth-last-child(n) / E:nth-of-type(n) / E:nth-last-of-type(n) / E:last-child / E:first-of-type / E:last-of-type / E:only-child / E:only-of-type / E:empty / E:target / E:enabled / E:disabled / E:checked / E:not(s) / E ~ F

```

##### @規則

```css

@page / @page:left / @page:right / @page:first

```

##### 色彩、背景

```css

background-attachment / background-image / background-position / background-repeat

```

##### 字體

```css

font-size-adjust / font-stretch / font-variant

```

##### 文字

```css

text-shadow / text-transform / white-space / word-spacing

```

##### 寬高

```css

min-width / min-height

```

##### 顯示

```css

direction / visibility / clip / overflow / unicode-bidi / z-index / display: list-item; / display: table; / display: inline-table / display: table-row-group / display: table-header-group / display: table-footer-group / display: table-row / display: table-column-group / display: table-column / display: table-cell / display: table-caption

```

##### Paged Media

```css

page / size / marks / orphans / widows

```

##### 列表

```css

list-style / list-style-type / list-style-position / list-style-image / marker-offset

```

##### 文繞圖

```css

float / clear

```

##### 位置

```css

position / top / right / bottom / left

```

##### 表格

```css

border-collapse / border-spacing / caption-side / empty-cells / table-layout

```

##### 挿入

```css

content / quotes / counter-reset / counter-increment

```

##### 大綱

```css

outline / outline-color / outline-style / outline-width

```

##### CSS 3.0 Speech

```css

-epub-cue / -epub-pause / -epub-rest / -epub-speak / -epub-speak-as / -epub-voice-family

```

##### CSS Text Level 3

```css

-epub-hyphens / text-transform: -epub-fullwidth / text-transform: -epub-fullsize-kana

```

##### CSS Writing Modes Module Level 3

```css

caption-side: before / caption-side: after

```

##### CSS3 Multi Column

```css

column-width / column-count / columns / column-gap / column-rule-color

```

##### CSS 2.0

```css

list-style-type: cjk-ideographic / list-style-type: hebrew / list-style-type: hiragana / list-style-type: hiragana-iroha / list-style-type: katakana / list-style-type: katakana-iroha

```

##### EPUB 3

```css

ex / in / cm / mm / pt / pc

-epub-ruby-position / display: oeb-page-head / display: oeb-page-foot

```

----



## 出版社須提供的資料

本文件僅提供了製作電子書的基本格式。

出版社若有任何不同的製作細節與要求，需要自行準備並且提供。這裡列出一些範例。

### 圖片與內容文件與推薦、限制尺寸及容量不同的對應方式

目前各RS考量到硬體性能，會對XHTML的內容文件的檔案大小及圖片尺寸設定上限。例如XHTML檔案不得過大，如超過1MB等；圖片檔案總像素不得超過350萬像素等。同時也會提供推薦尺寸，例如雜誌、漫畫單頁圖片建議長邊為2048像素等。

出版社需要提供檔案大於限制時的處理方式，如切割、縮放；以及小於推薦尺寸時的處理方式，如放大，保持原尺寸等。

### 出版社特有頁面的範本與樣式表

出版社如果要提供版權頁、書名頁、章節頁的話，建議使用本文件預設的HTML元素與CSS值來製作，並且提供給製作者套用。

### 體裁的簡化規則

當紙本版面複雜，在電子書上難以顯示時，出版社需提供簡化規則。例如：部分RS無法提供楷體字，可以粗的黑體替代之；多張文繞圖無法顯示時，該將圖片與文字如何配置等。

### 常會出問題的要素

* 圖片插入的位置

* 標題尺寸，以及置換字體時如何簡化體裁

* 標題層級的設定規則（如<h1>為書名，<h2>為章名，<h3>為中標等……）

* 設計性強的章名頁與標題目錄該如何處理（以文字呈現還是做成圖片等）

* 目錄頁與註解頁個項目的頁數要保留或者刪除

* 字型（人名與書名等專有名詞）

* 跨頁該如何處理

* 折頁該如何處理

* 寬字體、長字體的處理

* 同一行中的上下對齊

* 直排無法對其頁面正中時的處理

* 是否要呈現空白頁面

* 標題是否要換行的處理方式

* 分隔線圖片要換成文字記號還是以圖片插入

* 分欄該如何處理

* 背景圖該如何處理

* 版權頁的內容（例如是否要刪除印刷、經銷等資訊）

* 廣告頁的處理（雜誌）

* 「請參考第xx頁」的連結處理

* 索引該如何處理



其中標題與內文等區塊文字尺寸的相對關係，建議個別提供給製作者。可以由桌上排版軟體提供設定的字型大小與數值提供表單。

----



## 基本製作方式

製作電子書時請依照以下規則製作檔案。

關於檔案、資料夾名稱以及原始碼的命名規則，依照製作者不同會有不同的做法，但考量到未來修正時會造成麻煩，所以推進盡可能使用範本中提供的方法進行。

### 使用最新版的EPUBCHECK，檔案不能有任何錯誤（Error）

```

IDPF/epubcheck @ GitHub

https://github.com/IDPF/epubcheck/

若需要圖形介面版本，可使用：Pagina EPUB-CHECKER

http://www.pagina-online.de/produkte/epub-checker/

```

請注意，像iBooks等閱讀程式，在讀入EPUB後會加入專用的檔案，造成EPUBCHECK檢查時出現錯誤。請注意這種會改變原有檔案的RS。檢查時請使用製作好的原始檔案，不要放進RS後再取出進行檢查。

### 基本的資料夾構成與檔案名

```

root 資料夾

├ mimetype

├ META-INF 資料夾

│ └ container.xml

└ item 資料夾

   ├ standard.opf

   ├ navigation-documents.xhtml

   ├ image 資料夾

   ├ style 資料夾

   └ xhtml 資料夾

```

* root資料夾名稱可自行指定

* 檔案與資料夾名稱基本上為小寫英文（META-INF以及其他有明確規定者除外）

* 置放素材用的資料夾配合OPF裡的<item>元素，命名為「item」（規範上可自行更改）。

* 素材請放進item資料夾中的指定資料夾，請不要另外製作。

```

圖片檔案   ：「image」資料夾

CSS檔案    ：「style」資料夾

xhtml檔案  ：「xhtml」資料夾

```

* 以下檔案請不要修改（直接使用範本中的檔案）

   * root資料夾裡的「mimetype」

   * 「META-INF」資料夾裡的「container.xml」

* 各檔案的特別頁面，如書名與章名頁，建議與內文檔案以檔名做出區別。

> 說明：RS在處理EPUB內部資料夾的實作上，必須要能夠讀取item資料夾中子資料夾內的內容，也就是需要支援第二層路徑。

### 檔案規格

* 底本為跨頁的圖片或照片，請將左右頁結合成一張圖片，以對齊頁寬的方式插入。

* 請於底本換頁處，將內容切割成不同的XHTML檔案

   * 沒有換頁的作品，請將單一檔案控制在256KB上下。附近有標題時，於標題前分割；沒有標題時，於空行位置分割。

* 檔案的title全部填入書名

   * XHTML文件中的`<title>~</title>`間請輸入書名，建議可以輸入該章節的章名。

   * RS可以讀取各XHTML中的`<title>`來顯示在畫面之上，例如作為頁眉顯示。所以製作時請輸入正確的資訊。

* epub-type僅用於封面、導覽文件與註解

   * EPUB規範中`epub:type`語法可用來標注各頁與各區塊的功能。

   * 但若完全按照規範進行，會使得製作變得相當複雜，這裡僅推薦使用三項功能：

      * 封面頁面：`<body epub:type="cover" class="p-cover">`

      * 導覽文件：`<nav epub:type="toc" id="toc">`

      * 註解：請參考前面的記述語法。

### 簡單的編碼規則

* 文字編碼推薦使用UTF-8（無BOM）。

* 換行代碼：CR/LF於單一文件中不要混用。

* 不推薦使用本文件中未提及的HTML與CSS元素。

* 不加入出版社指定外的註解（Comment）

* Class名稱使用邏輯方式記載

   * Class與CSS在直排與橫排中，方向會有變化，現在Class使用邏輯方向，待未來CSS成熟後，可以直接對應。

    行頭             ：start         （直：top     横：left）

    行末             ：end           （直：bottom  横：right）

    行的前方         ：before        （直：right   横：top）

    行的後方         ：after         （直：left    横：bottom）

   * 但在頁面整體設定上，當頁面只有圖片時為橫排，使用top/right/bottom/left也沒關係。

   * 此外，在CSS中，行的頭尾正中方向為center，並且作為class名稱。

   * 為了方便起見，頁面方向（行的前後方向）正中視為middle。

* 本文內元素內各屬性的記載順序為`epub:type → class → id → src/href → alt → 其他`

* 為了避免過於複雜，`<p>`盡量不要指定class。

* 本文XHTML文件中HTML各元素的記述是否要換行。

   * `<div>`等區塊元素，必需於開始與結束標籤前後換行。

   * 但`<p>`與標題用的`<h1>~<h6>`開始標籤之後與關閉標籤之前，請不要換行。

```html

    ×          <h1>

                 文字

               </h1>

               <div><p>文字</p></div>

    ○          <h1>文字</h1>

               <div>

                 <p>文字</p>

               </div>

```

   * 行內元素（`<span>`等），原則上不換行。

   * `<a>`的狀況。當`<a>`不是包覆區塊元素（包括`<p>`在內）時，請不要換行。

此外，當元素內的變化太多，而不曉得層級對應關係時，請不要繼續使用既有的class，而使用專用的class。

像是「想要讓特定角色的台詞使用特別字體」、「信件內文想要加上框線」遇到這些可能會進行樣式修正的部分。與提在元素內加入多數class達到效果，不如新增定義專用的class。

----

## 範本：文字重排型

### 必要的設定檔案

關於範本內的顏色標注

灰色：全作品共通部分（原則上不進行更動）

藍色：全作品共通部分中，依照作品不同而須變更的部分

紅色：使用範本時特別需要注意的部分

黑色：非固定部分（依照作品與出版社而可有所差異）

#### <u>mimetype</u>

[檔名：mimetype]

```  

application/epub+zip

```

#### <u>META-INF中的container.xml</u>

[檔名：container.xml]

```xml

<?xml version="1.0"?>

<container

 version="1.0"

 xmlns="urn:oasis:names:tc:opendocument:xmlns:container"

>

    <rootfiles>

        <rootfile

         full-path="item/standard.opf"

         media-type="application/oebps-package+xml"

        />

    </rootfiles>

</container>

```

#### <u>導覽文件</u>

[檔名：navigation-documents.xhtml]

備註：

* 連結項目與列表層級依照作品內容修改。

* 若出版社沒有特別指示，僅提供封面頁、目錄頁、版權頁的連結即可。

* 本規格不支援在導覽文件中加入沒有連結的項目。

* 導覽文件的顯示方式，由RS自行決定。

* 若要讓導覽文件作為本文內的目錄頁顯示時，請參考後面本文頁面的範例，加入樣式表。

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

>

    <head>

        <meta charset="UTF-8"/>

        <title>Navigation</title>

    </head>

    <body>

        <nav epub:type="toc" id="toc">

            <h1>目錄</h1>

            <ol>

                <li><a href="xhtml/p-cover.xhtml">封面</a></li>

                <li><a href="xhtml/p-toc.xhtml">目錄</a></li>

                <li><a href="xhtml/p-colophon.xhtml">版權頁</a></li>

            </ol>

        </nav>

    </body>

</html>

```

#### <u>OPF檔案</u>

[檔名：standard.opf]

備註：

* 當RS具備顯示`<dc:title>`資訊功能時，預設會在RS內某一處顯示全部的記載內容。

* 當RS具備顯示`<dc:creator>`資訊功能時，預設會將複數`<dc:creator>`於RS內某一處顯示全部的記載內容。（連結複數作者的符號與角色，由RS自行決定之）

* 作者名要一一分開，還是於單一`<dc:creator>`中記載全部作者，由出版社自行決定。若分別顯示，必須按照出版社給與各作者的「role」值，以及作者的顯示順序顯示。

* 檔案id（`unique-identifier`）原則上使用`urn:isbn:xxxxxxxxxxxx`，ISBN間不加連字號。沒有ISBN時，輸入UUID。

* 更新日期沒有特別指定時，輸入製作日期。

* 更新日期不應該對讀者顯示。

* 封面圖片在沒有特別指示下，為了便於辨識，請使用相同檔案名（cover.jpg)。

* 書為橫排時，將`<spine>`中的`page-progression-direction`的`rtl`改為`ltr`，或者刪除，即沒有指定`page-progression-direction`時，預設為橫排書。

```xml

<?xml version="1.0" encoding="UTF-8"?>

<package

 xmlns="http://www.idpf.org/2007/opf"

 version="3.0"

 xml:lang="zh-TW"

 unique-identifier="unique-id"

 prefix="ibooks: http://vocabulary.itunes.apple.com/rdf/ibooks/vocabulary-extensions-1.0/ rendition: http://www.idpf.org/vocab/rendition/#"
>

    <metadata xmlns:dc="http://purl.org/dc/elements/1.1/">

        <!-- 書名 -->

        <dc:title id="title">書名</dc:title>

        <!-- 作者名 -->

        <dc:creator id="creator01">作者名１</dc:creator>

        <meta refines="#creator01" property="role" scheme="marc:relators">aut</meta>

        <meta refines="#creator01" property="display-seq">1</meta>

        <dc:creator id="creator02">作者名２</dc:creator>

        <meta refines="#creator02" property="role" scheme="marc:relators">aut</meta>

        <meta refines="#creator02" property="display-seq">2</meta>

        <!-- 出版社名 -->

        <dc:publisher id="publisher">出版社名</dc:publisher>

        <!-- 語言 -->

        <dc:language>zh-TW</dc:language>

        <!-- 檔案id -->

        <dc:identifier id="unique-id">urn:uuid:d7a8d311-7cd0-40df-9443-65847561decf</dc:identifier>

        <!-- 更新日期 -->

        <meta property="dcterms:modified">2014-01-01T00:00:00Z</meta>

        <!-- iBook指定字體 -->

        <meta property="ibooks:specified-fonts">true</meta>

    </metadata>

    <manifest>

        <!-- navigation —>

        <item media-type="application/xhtml+xml" id="toc" href="navigation-documents.xhtml" properties="nav"/>

        <!-- style -->

        <item media-type="text/css" id="book-style"     href="style/book-style.css"/>

        <item media-type="text/css" id="style-reset"    href="style/style-reset.css"/>

        <item media-type="text/css" id="style-standard" href="style/style-standard.css"/>

        <item media-type="text/css" id="style-advance"  href="style/style-advance.css"/>

        <item media-type="text/css" id="style-check"    href="style/style-check.css"/>

        <!-- image -->

        <item media-type="image/jpeg" id="cover"      href="image/cover.jpg" properties="cover-image"/>

        <item media-type="image/png"  id="logo-bunko" href="image/logo-bunko.png"/>

        <item media-type="image/jpeg" id="kuchie-001" href="image/kuchie-001.jpg"/>

        <item media-type="image/jpeg" id="img-001"    href="image/img-001.jpg"/>

        <item media-type="image/jpeg" id="ad-001"     href="image/ad-001.jpg"/>

        <!-- xhtml -->

        <item media-type="application/xhtml+xml" id="p-cover"       href="xhtml/p-cover.xhtml properties="svg""/>

        <item media-type="application/xhtml+xml" id="p-fmatter-001" href="xhtml/p-fmatter-001.xhtml properties="svg""/>

        <item media-type="application/xhtml+xml" id="p-titlepage"   href="xhtml/p-titlepage.xhtml"/>

        <item media-type="application/xhtml+xml" id="p-caution"     href="xhtml/p-caution.xhtml"/>

        <item media-type="application/xhtml+xml" id="p-toc"         href="xhtml/p-toc.xhtml"/>

        <item media-type="application/xhtml+xml" id="p-001"         href="xhtml/p-001.xhtml"/>

        <item media-type="application/xhtml+xml" id="p-002"         href="xhtml/p-002.xhtml"/>

        <item media-type="application/xhtml+xml" id="p-003"         href="xhtml/p-003.xhtml"/>

        <item media-type="application/xhtml+xml" id="p-004"         href="xhtml/p-004.xhtml"/>

        <item media-type="application/xhtml+xml" id="p-005"         href="xhtml/p-005.xhtml"/>

        <item media-type="application/xhtml+xml" id="p-colophon"    href="xhtml/p-colophon.xhtml"/>

        <item media-type="application/xhtml+xml" id="p-ad-001"      href="xhtml/p-ad-001.xhtml"/>

    </manifest>

    <spine page-progression-direction="rtl">

        <itemref linear="yes" idref="p-cover"       properties="rendition:layout-pre-paginated 
													    rendition:spread-none 
													    rendition:page-spread-center"/>

        <itemref linear="yes" idref="p-fmatter-001" properties="rendition:layout-pre-paginated 
														rendition:spread-auto 
														page-spread-left"/>

        <itemref linear="yes" idref="p-titlepage"   properties="page-spread-left"/>

        <itemref linear="yes" idref="p-caution"     properties="page-spread-left"/>

        <itemref linear="yes" idref="p-toc"         properties="page-spread-left"/>

        <itemref linear="yes" idref="p-001"         properties="page-spread-left"/>

        <itemref linear="yes" idref="p-002"         properties="page-spread-left"/>

        <itemref linear="yes" idref="p-003"         properties="page-spread-left"/>

        <itemref linear="yes" idref="p-004"/>

        <itemref linear="yes" idref="p-005"/>

        <itemref linear="yes" idref="p-colophon"    properties="page-spread-left"/>

        <itemref linear="yes" idref="p-ad-001"/>

    </spine>

</package>

```

### XHTML文件檔案

#### <u>關於範本內的顏色標注</u>

灰色：全作品共通部分（原則上不進行更動）

藍色：全作品共通部分中，依照作品不同而須變更的部分

紅色：使用範本時特別需要注意的部分

黑色：非固定部分（依照作品與出版社而可有所差異）

綠色的□：代表全形空白

#### <u>關於排版方向</u>

排版方向於各頁的`<html>`中依以下記載方式指定

```html

class="hltr"：横排 排版方向 h（Horizontal）        行方向 ltr（Left To Right）

class="vrtl"：直排 排版方向 v（Vertical）          行方向 rtl（Right To Left）

```



* 目前CSS3尚不支援「直排的ltr」。

* 只有圖片的頁面，為將圖片放在正中央，採用橫排。

#### <u>封面頁</u>

  [檔名：p-cover.xhtml]

  備註：

* 預設為置放為正中央

* 除圖片以外，不加入任何內容

* 沒有封面圖片時，RS需要加入代替圖片

```OPF

<manifest>

  <item media-type="application/xhtml+xml" href="p-cover.xhtml" id="p=cover.xhtml" properties="svg" />

</manifest>

<spine>

  <itemref linear="yes" idref="p-cover" properties="rendition:layout-pre-paginated rendition:spread-none rendition:page-spread-center"/>

</spine>

```

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="hltr"

>

    <head>

        <meta charset="UTF-8"/>

        <meta name="viewport" content="width=圖寬,height=圖高" />

        <style type="text/css">
          html, body { margin: 0; padding: 0; width: 100%; height: 100%;}
        </style>

        <title>書名</title>

    </head>

    <body epub:type="cover" class="p-cover">

        <svg xmlns="http://www.w3.org/2000/svg" version="1.1"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            width="100%" height="100%" viewBox="0 0 圖寬 圖高">
            <image width="圖寬" height="圖高" xlink:href="../image/cover.jpg（封面圖檔名）"/>
        </svg>

    </body>

</html>

```

#### <u>正文前（本例為插畫）</u>

[檔名：p-fmatter-***.xhtml]（本例為「p-fmatter-001.xhtml」

備註：

* 封面頁到書名頁之間的頁面，方便上全稱為正文前

* 圖片頁使用SVG Wrapping，**必需**於OPF檔案的`<manifest>`項目加入`properties="svg"`，且於`<spine>`項目加入`properties="rendition:layout-pre-paginated rendition:spread-none rendition:page-spread-x"`

* 圖片頁於`<head>`內不帶入預設的CSS，而以以下CSS取代：  

```
<style type="text/css">
  html, body { margin: 0; padding: 0; width: 100%; height: 100%;}
</style>
```

* RS需要支援圖片頁`rendition:page-spread-x`指定的左頁（`left`）與右頁（`right`），推薦支援置中（`center`）

* 不限使用圖片頁

```OPF

<manifest>

  <item media-type="application/xhtml+xml" href="p-fmatter-001.xhtml" id="p-fmatter-001.xhtml" properties="svg" />

</manifest>

<spine>

  <itemref linear="yes" idref="p-fmatter-001" properties="rendition:layout-pre-paginated rendition:spread-none rendition:page-spread-left"/>

</spine>

```

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="hltr"

>

    <head>

        <meta charset="UTF-8"/>

        <meta name="viewport" content="width=圖寬,height=圖高" />

        <style type="text/css">
          html, body { margin: 0; padding: 0; width: 100%; height: 100%;}
        </style>

        <title>書名</title>

    </head>

    <body class="p-image">

         <svg xmlns="http://www.w3.org/2000/svg" version="1.1"
            xmlns:xlink="http://www.w3.org/1999/xlink"
            width="100%" height="100%" viewBox="0 0 圖寬 圖高">
            <image width="圖寬" height="圖高" xlink:href="../image/kuchie-001.jpg（圖檔名）"/>
        </svg>

    </body>

</html>

```

#### <u>書名頁</u>

[檔名：p-titlepage.xhtml]

備註：內容與排版方向，依照出版社與作品而不同。（下面內容與Class名為參考用）

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="hltr"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/book-style.css"/>

    </head>

    <body class="p-titlepage">

        <div class="main">

            <div class="book-title">

                <div class="book-title-before">

                	<p>副標・前</p>

                </div>

                <div class="book-title-main">

                	<p>主標</p>

            	</div>

                <div class="book-title-after">

                	<p>副標・後</p>

                </div>

            </div>

            <div class="author">

                <p>作者名１</p>

                <p>作者名２</p>

            </div>

            <div class="label">

                <p class="label-logo"><img src="../image/logo-bunko.png" alt=""/></p>

                <p class="label-name">●●文庫</p>

            </div>

        </div>

    </body>

</html>

```

#### <u>電子版用的說明頁面</u>

[檔名：p-caution.xhtml]

備註：

* 內容與排版方向，依照出版社與作品而不同。

* 本頁預設適用於所有書籍，說明「版面與文字尺寸與印刷書有所不同」，可以追加各作品特別需要注意之處。若沒有特別指示，可以刪除。

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="vrtl"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/book-style.css"/>

    </head>

    <body class="p-caution">

        <div class="main">

        	<p>說明與印刷書的差異，禁止複製轉載等等。</p>

        </div>

    </body>

</html>

```

#### <u>目錄頁</u>

[檔名：p-toc.xhtml]

備註：

* 若使用導覽文件作為書內目錄的話，不需要加入此頁

* 內容與排版方向，依照作品而有所不同

* 沒有特別指示的狀況下，連結的頁面需要加入id定位

* 沒有特別指示的狀況下，跳轉後頁面不需要設定返回目錄頁的連結

* 標題元素等使用的class不是固定，可自行變更（可如`<h1 class="gfont font-1em30">`這樣，直接在Class裡指定尺寸與字體等）

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="vrtl"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/book-style.css"/>

    </head>

    <body class="p-toc">

        <div class="main">

            <h1 class="mokuji-midashi">□目錄標題</h1>

            <p><br/></p>

            <p><br/></p>

            <p><a href="p-001.xhtml#toc-001">目錄項目１</a></p>

            <p>□<a href="p-002.xhtml#toc-002"><span class="font-0em80">目錄項目２</span></a></p>

            <p>□<a href="p-002.xhtml#toc-003"><span class="font-0em80">目錄項目３</span></a></p>

        </div>

    </body>

</html>

```

#### <u>章名頁</u>

[檔名：p-xxx.xhtml]  (本例為`p-001.xhtml`)

備註：

* 內容與排版方向，依照作品而有所不同

* 關於由目錄連結連入的id指定位置（本文頁面相同）

   * 沒有特別指示下，若有與目錄項目相同的標題元素，將id指定於該處

   * 若沒有標題元素（例如只有圖片等）或者在標題前有需要顯示的內容的話，請在連結內容前最接近的`<p>`或`<div>`等於CSS中指定為{display: block;}等元素（區塊層級元素）加上id

* 檔案名使用如「p-001」三位連續編號時，若超過三位數時，請自行挑整檔案名稱

* 標題元素等使用的class不是固定，可自行變更（可如`<h1 class="gfont font-1em30">`這樣，直接在Class裡指定尺寸與字體等）

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="vrtl"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/book-style.css"/>

    </head>

    <body class="p-tobira">

        <div class="main">

        	<p class="tobira-midashi" id="toc-001">第一章□天地玄黃宇宙洪荒</p>

        </div>

    </body>

</html>

```

#### <u>內文頁面（直排）</u>

[檔名：p-***.xhtml]  (本例為`p-002.xhtml`)

備註：

* 內容與排版方向，依照作品而有所不同

* 標題元素等使用的class不是固定，可自行變更（可如`<h1 class="gfont font-1em30">`這樣，直接在Class裡指定尺寸與字體等）

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="vrtl"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/book-style.css"/>

    </head>

    <body class="p-text">

        <div class="main">

            <h1 class="oo-midashi" id="toc-002">第一節□天地玄黃宇宙洪荒</h1>

            <p><br/></p>

            <p><br/></p>

            <p>□□本文為範例。</p>

            <p>□□「本文為範例」</p>

            <p><br/></p>

            <h2 class="ko-midashi" id="toc-003">□□□□第一項</h2>

            <p><br/></p>

            <p>□□本文為範例。</p>

            <p>□□本文為範例。</p>

            <p><img class="fit" src="../image/img-001.jpg" alt=""/></p>

            <p>□□本文為範例。</p>

        </div>

    </body>

</html>

```

#### <u>內文頁面（橫排）</u>

[檔名：p-***.xhtml]  (本例為`p-003.xhtml`)

備註：

* 只改變`<html>`內的class，基本上與橫排相同

* 內容與排版方向，依照作品而有所不同

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="hltr"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/book-style.css"/>

    </head>

    <body class="p-text">

        <div class="main">

            <h1 class="oo-midashi" id="toc-002">第一節□天地玄黃宇宙洪荒</h1>

            <p><br/></p>

            <p><br/></p>

            <p>□□本文為範例。</p>

            <p>□□「本文為範例」</p>

            <p><br/></p>

            <h2 class="ko-midashi" id="toc-003">□□□□第一項</h2>

            <p><br/></p>

            <p>□□本文為範例。</p>

            <p>□□本文為範例。</p>

            <p><img class="fit" src="../image/img-001.jpg" alt=""/></p>

            <p>□□本文為範例。</p>

        </div>

    </body>

</html>

```

#### <u>內文頁面（只有圖片）</u>

[檔名：p-***.xhtml]  (本例為`p-004.xhtml`)

備註：

* 內容與排版方向，依照作品而有所不同

* 預設為置放為正中央

* 如果靠右對齊也可以的話，`<html>`的class指定為直排也沒關係

* 除圖片以外，不加入任何內容

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="hltr"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/book-style.css"/>

    </head>

    <body class="p-image">

        <div class="main">

        	<p><img class="fit" src="../image/img-001.jpg" alt=""/></p>

        </div>

    </body>

</html>

```

#### <u>指定頁面整體的對齊位置</u>

[檔名：p-***.html]  (本例為`p-005.xhtml`)

備註：

* 以文字為主和以圖片為主的頁面都相同

* 頁面整體的對齊方向，於`<div class="main">`裡，指定`class="align-***"`

```

align-justify ： 對齊兩端（只有最後一行對齊行頭、文字內容內文以此為預設值）

align-start   ： 對齊行首（只有圖片的頁面若為橫排的話，請注意start=對左靠齊）

align-left    ： 對齊行首

align-center  ： 對齊行中（橫排時為天地的中央，直排時為左右中央，圖片頁面的預設值）

align-end     ： 對齊行尾

align-right   ： 對齊行尾

```



* 以下為圖片頁面對左對齊的範例

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="hltr"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/book-style.css"/>

    </head>

    <body class="p-image">

        <div class="main align-left">

        	<p><img class="fit" src="../image/img-001.jpg" alt=""/></p>

        </div>

    </body>

</html>

```

#### <u>版權頁</u>

[檔名：p-colophon.xhtml]

備註：內容與排版方向，依照作品而有所不同（以下內容包含class名全為參考用）

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="hltr"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/book-style.css"/>

    </head>

    <body class="p-colophon">

        <div class="main">

            <div class="book-title">

                <div class="book-title-before">

                	<p>副標題・前</p>

                </div>

                <div class="book-title-main">

                	<p>主標題</p>

                </div>

                <div class="book-title-after">

                	<p>副標題・後</p>

                </div>

            </div>

            <div class="author">

                <p>作者名１</p>

                <p>作者名２</p>

            </div>

            <div class="label">

            	<p class="label-logo"><img src="../image/logo-bunko.png" alt=""/></p>

            </div>

            <div class="release-date">

            	<p>民國xx年xx月xx日□發行</p>

            </div>

            <div class="publisher-data">

                <p class="publish-person">發行人□●●●</p>

                <p class="publish-company">出版社□●●出版</p>

                <p class="publish-address">台北市●●●●</p>

                <p class="publish-url">http://www.***.com.tw/</p>

            </div>

            <div class="copyright">

                <p>(C) author01 20xx</p>

                <p>(C) author02 20xx</p>

            </div>

            <div class="kotowarigaki">

            	<p>（版權警告）</p>

            </div>

            <div class="original-books">

                <p>本電子書基於以下書籍製作</p>

                <p class="original-first-edition">《底本名》民國xx年xx月xx日初版</p>

                <p class="original-used-edition">民國xx年xx月xx日第xx版</p>

            </div>

        </div>

    </body>

</html>

```

#### <u>廣告頁</u>

[檔名：p-ad-***.xhtml]  (本例為`p-ad-001.xhtml`)

備註：

* 內容與排版方向，依照作品而有所不同

*  不限使用圖片頁

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="hltr"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/book-style.css"/>

    </head>

    <body class="p-image">

        <div class="main">

        	<p><img class="fit" src="../image/ad-001.jpg" alt=""/></p>

        </div>

    </body>

</html>

```

### 【參考資訊】本文件不推薦的項目

#### <u>直排文字居中頁面</u>

備註：

* 混合排版方向支援狀況不一，需要確認是否每一款RS都能支援

* 內容會溢出頁面而有部分受到裁切，需要確認顯示的螢幕尺寸

* 橫排中直排區塊為子項目，更改排版方向時需要注意不會變更的Class的值（特別為邊界）

* 由於天地的邊界為0，必要時需要在`<div class="main">`的內部再加上一層`<div>`並且設定margin與padding。（使用本方法時，`<body>`以及`<div class="main">`等不可以追加margin與padding。.p-text等於`<body>`指定的class，追加margin等可能不會如預期一般顯示

* 文字頁面若將`vrtl block-align-center`指定於`<div class="main">`，而不是`<body>`時，必須將`<body>`的margin與padding指定為0

* 想要向左對齊時，請將下記的`block-align-center`更改為`block-align-left (or start)`（橫排頁面的end=right，請多加注意

* 章名頁（.p-tobira）等使用方法相同

* 橫排想要指定為頁面正中央時，請將以下的hltr更換成vrtl，這時，main若不指定為width-100per，就會向右對齊（基本上為直排，所以會由右向左排列元素）。

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="hltr"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/book-style.css"/>

    </head>

    <body class="p-text">

        <div class="main vrtl block-align-center">

            <div class="start-2em">      // ←頁面整體的縮排，指定於更裡面的<div>

            	<p>天地玄黃，宇宙洪荒</p>

            </div>

        </div>

    </body>

</html>

```

以下為將圖片置放於左下角的範例

備註：

* 想要對齊頁底時，若`<body>`下面一層的`<div class="main">`的高不指定為100%的話，Webkit系的排版引擎位置可能會錯開（橫排時，請將寬度設定為100%）

* 以下案例為了方便確認效果，圖片設定為整頁高度的50%（`<img class="fit max-height-050per"/>`）

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

 class="hltr"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/book-style.css"/>

    </head>

    <body class="p-text">

        <div class="main vrtl block-align-left height-100per">

            <div class="align-end">  // ←位於頁面全體下方，請設定於內側的<div>

            	<p><img class="fit max-height-050per" src="../image/img-001.jpg" alt=""/></p>

            </div>

        </div>

    </body>

</html>

```

----

## 範本：固定版面型

固定版面型範本，RS在實作上需要注意兩點：

一是內頁圖片使用SVG Wrapping，透過SVG語法來包覆圖片，放大到整頁滿版顯示。二是透過ImageMap功能，做到應用於目錄等內頁連結。

### 必要的設定檔案

關於範本內的顏色標注

灰色：全作品共通部分（原則上不進行更動）

藍色：全作品共通部分中，依照作品不同而須變更的部分

紅色：使用範本時特別需要注意的部分

黑色：非固定部分（依照作品與出版社而可有所差異）

#### <u>mimetype</u>

[檔名：mimetype]

備註：與文字重排型相同

```  

application/epub+zip

```

#### <u>META-INF中的container.xml</u>

[檔名：container.xml]

備註：與文字重排型相同

```xml

<?xml version="1.0"?>

<container

 version="1.0"

 xmlns="urn:oasis:names:tc:opendocument:xmlns:container"

>

    <rootfiles>

        <rootfile

         full-path="item/standard.opf"

         media-type="application/oebps-package+xml"

        />

    </rootfiles>

</container>

```

#### <u>導覽文件</u>

[檔名：navigation-documents.xhtml]

備註：基本與文字重排型相同

檔名為連續編號時，可以適當調整（以下案例中目錄為p-001.xhtml)

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

>

    <head>

        <meta charset="UTF-8"/>

        <title>目錄</title>

    </head>

    <body>

        <nav epub:type="toc" id="toc">

            <h1>目錄</h1>

            <ol>

                <li><a href="xhtml/p-cover.xhtml">封面</a></li>

                <li><a href="xhtml/p-001.xhtml">目錄</a></li>

                <li><a href="xhtml/p-colophon.xhtml">版權頁</a></li>

            </ol>

        </nav>

    </body>

</html>

```

#### <u>OPF檔案</u>

[檔名：standard.opf]

備註：

* 與文字重排型的差異為以下各點：

   * 於`<package>`元素中追加prefix

   * 於`<!--Fixed-Layout Document指定-->`部份追加兩個`<meta>`元素

   * 樣式表僅使用fixed-layout.cc

   * 封面頁的`<spine>`元素中的`<itemref>`追加`properties="rendition:page-spread-center`

   * 封面頁以外的各頁面，`<spine>`元素中的`<itemref>`左右頁必須成對

   * 其他與文字重排相同

* `<spine>`元素中的`<itemref>`，若idref重複的話會出現問題，如無法顯示，頁面迴圈，當想讓相同圖片出現兩次以上時，推薦使用不同的xhtml（如第二次顯示空白頁時，使用white2.xhtml等）

* 

```xml

<?xml version="1.0" encoding="UTF-8"?>

<package

 xmlns="http://www.idpf.org/2007/opf"

 version="3.0"

 xml:lang="zh-TW"

 unique-identifier="unique-id"

 prefix="rendition: http://www.idpf.org/vocab/rendition/#

>

    <metadata xmlns:dc="http://purl.org/dc/elements/1.1/">

        <!-- 書名 -->

        <dc:title id="title">書名１</dc:title>

        <!-- 作者名 -->

        <dc:creator id="creator01">作者名１</dc:creator>

        <meta refines="#creator01" property="role" scheme="marc:relators">aut</meta>

        <meta refines="#creator01" property="display-seq">1</meta>

        <dc:creator id="creator02">作者名２</dc:creator>

        <meta refines="#creator02" property="role" scheme="marc:relators">aut</meta>

        <meta refines="#creator02" property="display-seq">2</meta>

        <!-- 出版社名 -->

        <dc:publisher id="publisher">出版社名</dc:publisher>

        <!-- 語言 -->

        <dc:language>zh-TW</dc:language>

        <!-- 書籍id -->

        <dc:identifier id="unique-id">urn:uuid:860ddf31-55a4-449a-8cc9-3c1837657a15</dc:identifier>

        <!-- 更新日期 -->

        <meta property="dcterms:modified">2014-01-01T00:00:00Z</meta>

        <!-- Fixed-Layout Documents指定 -->

        <meta property="rendition:layout">pre-paginated</meta>

        <meta property="rendition:spread">landscape</meta>

    </metadata>

    <manifest>

        <!-- navigation -->

        <item media-type="application/xhtml+xml" id="toc" href="navigation-documents.xhtml" properties="nav"/>

        <!-- style -->

        <item media-type="text/css" id="fixed-layout-jp" href="style/fixed-layout-jp.css"/>

        <!-- image -->

        <item media-type="image/jpeg" id="cover"      href="image/cover.jpg" properties="cover-image"/>

        <item media-type="image/jpeg" id="i-white"    href="image/i-white.jpg"/>

        <item media-type="image/jpeg" id="i-001"      href="image/i-001.jpg"/>

        <item media-type="image/jpeg" id="i-002"      href="image/i-002.jpg"/>

        <item media-type="image/jpeg" id="i-003"      href="image/i-003.jpg"/>

        <item media-type="image/jpeg" id="i-004"      href="image/i-004.jpg"/>

        <item media-type="image/jpeg" id="i-005"      href="image/i-005.jpg"/>

        <item media-type="image/jpeg" id="i-colophon" href="image/i-colophon.jpg"/>

        <!-- xhtml -->

        <item media-type="application/xhtml+xml" id="p-cover"    href="xhtml/p-cover.xhtml"    properties="svg"/>

        <item media-type="application/xhtml+xml" id="p-white"    href="xhtml/p-white.xhtml"    properties="svg"/>

        <item media-type="application/xhtml+xml" id="p-001"      href="xhtml/p-001.xhtml"      properties="svg"/>

        <item media-type="application/xhtml+xml" id="p-002"      href="xhtml/p-002.xhtml"      properties="svg"/>

        <item media-type="application/xhtml+xml" id="p-003"      href="xhtml/p-003.xhtml"      properties="svg"/>

        <item media-type="application/xhtml+xml" id="p-004"      href="xhtml/p-004.xhtml"      properties="svg"/>

        <item media-type="application/xhtml+xml" id="p-005"      href="xhtml/p-005.xhtml"      properties="svg"/>

        <item media-type="application/xhtml+xml" id="p-colophon" href="xhtml/p-colophon.xhtml" properties="svg"/>

        <item media-type="application/xhtml+xml" id="p-white2"   href="xhtml/p-white2.xhtml"   properties="svg"/>

    </manifest>

    <spine page-progression-direction="rtl">

        <itemref linear="yes" idref="p-cover"    properties="rendition:page-spread-center"/>

        <itemref linear="yes" idref="p-white"    properties="page-spread-right"/>

        <itemref linear="yes" idref="p-001"      properties="page-spread-left"/>

        <itemref linear="yes" idref="p-002"      properties="page-spread-right"/>

        <itemref linear="yes" idref="p-003"      properties="page-spread-left"/>

        <itemref linear="yes" idref="p-004"      properties="page-spread-right"/>

        <itemref linear="yes" idref="p-005"      properties="page-spread-left"/>

        <itemref linear="yes" idref="p-colophon" properties="page-spread-right"/>

        <itemref linear="yes" idref="p-white2"   properties="page-spread-left"/>

    </spine>

</package>

```

### XHTML文件檔案

#### <u>關於範本內的顏色標注</u>

灰色：全作品共通部分（原則上不進行更動）

藍色：全作品共通部分中，依照作品不同而須變更的部分

紅色：使用範本時特別需要注意的部分

黑色：非固定部分（依照作品與出版社而可有所差異）

#### <u>封面頁</u>

[檔名：p-cover.xhtml]

備註：

* 下記三處藍色記載圖片原來尺寸

* 圖片尺寸於書內請統一

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/fixed-layout.css"/>

        <meta name="viewport" content="width=848, height=1200"/>

    </head>

    <body epub:type="cover">

        <div class="main">

            <svg xmlns="http://www.w3.org/2000/svg" version="1.1"

             xmlns:xlink="http://www.w3.org/1999/xlink"

             width="100%" height="100%" viewBox="0 0 848 1200">

            	<image width="848" height="1200" xlink:href="../image/cover.jpg"/>

            </svg>

        </div>

    </body>

</html>

```

#### <u>內文頁</u>

[檔名：p-***.xhtml（範例為`p-002.xhtml`）]

備註：除了沒有`epub:type="cover"`以外，和封面頁相同

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/fixed-layout.css"/>

        <meta name="viewport" content="width=848, height=1200"/>

    </head>

    <body>

        <div class="main">

            <svg xmlns="http://www.w3.org/2000/svg" version="1.1"

             xmlns:xlink="http://www.w3.org/1999/xlink"

             width="100%" height="100%" viewBox="0 0 848 1200">

            	<image width="848" height="1200" xlink:href="../image/cover.jpg"/>

            </svg>

        </div>

    </body>

</html>

```

#### <u>內文ImageMap（Clickable Map）頁面</u>

[檔名：p-***.xhtml（範例為`p-001.xhtml`）]

備註：

* a元素的`xlink:href`屬性，請記載要連結的檔案名稱

* rect元素的x與y屬性，請記載點擊範圍開始位置（左上）的座標

* rect元素的width與height屬性，請記載點擊範圍的尺寸

```html

<?xml version="1.0" encoding="UTF-8"?>

<!DOCTYPE html>

<html

 xmlns="http://www.w3.org/1999/xhtml"

 xmlns:epub="http://www.idpf.org/2007/ops"

 xml:lang="zh-TW" lang="zh-TW"

>

    <head>

        <meta charset="UTF-8"/>

        <title>書名</title>

        <link rel="stylesheet" type="text/css" href="../style/fixed-layout.css"/>

        <meta name="viewport" content="width=848, height=1200"/>

    </head>

    <body>

        <div class="main">

            <svg xmlns="http://www.w3.org/2000/svg" version="1.1"

             xmlns:xlink="http://www.w3.org/1999/xlink"

             width="100%" height="100%" viewBox="0 0 848 1200">

                <image width="848" height="1200" xlink:href="../image/i-001.jpg"/>

                <a xlink:href="p-002.xhtml" target="_top"><rect fill-opacity="0.0" x="476" y="1000" width="300" height="60"/></a>

                <a xlink:href="p-colophon.xhtml" target="_top"><rect fill-opacity="0.0" x="476" y="1075" width="300" height="60"/></a>

        	</svg>

        </div>

    </body>

</html>

```

----



## 格式一覽

> TODO: 補 CSS sample file

> 說明：關於本節中提及之樣式表範本，可由此處下載：http://...

### 段落

備註：

所有的段落由`<p></p>`包覆（樣式表中`<p>`的margin與padding設定為0）。

**HTML元素**

```html

<p></p>：段落

```

例：

```html

<p>文字</p>

<p>文字</p>

```

### 換行、空白行

備註：

空白行，原則上使用`<p><br/></p>`。

**HTML元素**

```html

<p><br/></p> ： 空白行

```

例：空一行

```html

<p>文字</p>

<p><br/></p>

<p>文字</p>

```

### 縱中橫排

備註：

縱中橫排內預設不使用上標、下標與文字裝飾，要使用時，請製作圖片取代。

若要指定字體等，請於縱中橫外另以元素包覆指定。

**CSS class**

```css

class="tcy" ： 1~3字為止。4字以上請製作成圖片（插入方法請參考缺字圖片項目）

```



例：二位數的縱中橫排

```html

<span class="tcy">99</span>

```

### 直排時的文字方向

**CSS Class**

```css

class="sideways"  ： 順時針旋轉90度

class="upright"   ： 直立（全型）

class="upright-1" ： 直立（半型）※不會居中對齊而另外指定

```

例：順時針旋轉90度

```html

10 <span class="sideways">〜</span> 20

```

例：直立（全型）

```html

<span class="upright">－</span>（減號）

```

例：直立（半型）

```html

這個<span class="upright-1">É</span>是法文使用的字母

```

### Ruby文字

備註：

Ruby文字為日文標注於漢字旁的小字，也應用於中文的注音符號。但目前中文注音符號的聲調符號還未獲得共識，所以暫時不使用Ruby標注來顯示。

但Ruby文字廣泛用於日文翻譯的輕小說，標注於側旁的文字主要有：漢字、直立的英文縮寫或者橫置的英文單字；當要讓英文縮寫一字一字直立時，請使用全型英文字母；以外使用半型英文即可。

**HTML元素**

```html

<ruby>內文標注處<rt>標注文字</rt></ruby>

```

例：漢字

```html

<ruby>Endless Enigma<rt>無盡的謎</rt></ruby>

```

例：直立英文（英文使用全型字母）

```html

<ruby>大眾化<rt>ＰＯＰ</rt></ruby>

```

例：橫置英文

```html

<ruby>他們稱那裡為樂園<rt>They call it paradise</rt></ruby>

```

### 指定特殊文字

#### <u>字符實體引用</u>

備註：在XML規範下，有五個字符需要轉換為字符實體引用（Character entity reference）。但「”」與「’」在本文中可以不轉換，直接以純文字插入使用。

```html

& : &amp;

< : &lt;

> : &gt;

" : &quot;

' : &apos;

```

### 文字裝飾

**CSS Class**

字體

```css

class="mfont”：明體

class="gfont”：黑體

class="kfont”：楷體

```

文字尺寸（可使用的數值需確認CSS是否有定義

```css

class="font-0em80"  ： 指定標準文字尺寸（em） （本例為指定0.8em）

class="font-080per" ： 指定放大縮小比率（%）（本例為指定80%）

```

#### <u>粗體與斜體</u>

粗體與斜體原則上使用HTML中的`<b>`與`<i>`標籤，但用於書籍內容強調時，可以使用句語義的`<em>`與`<strong>`，但需要於CSS中定義顯示方式，避免使用預設的樣式顯示。

**HTML元素**

```html

<b>：字體不變，單純加粗文字

<i>：字體不變，單純使文字斜置（一般用於芝加哥格式的英文書名，中文較少使用斜體）

<em>：標注強調文字

<strong>：標注另一種強調的文字

```

**CSS Class**

以下範例為使用`<em>`標籤標注內文頁中文書名，當RS支援楷體時使用楷體，不支援楷體時使用黑體，並且不為斜體、不加粗文字。

```css

em { font-family: cursive, sans-serif;

     font-style: normal;

     font-weight: notmal; }

```

### 刪除線

備註：若要兩條刪除線，請做成圖片。

**CSS Class**

```css

class="line-through"：刪除線（一條線）

```

### 私名號、書名號

#### <u>私名號</u>

私名號可使用HTML的`<u>`元素包覆，或者使用CSS指定。

**HTML元素**

```html

<u></u>

```

**CSS Class**

```css

u,.em-line { text-decoration: underline;}

```

例：

```html

光是<u>台北市</u>的人口

光是<span class="em-line">台北市</span>的人口

```

#### <u>書名號</u>

**CSS Class**

```css

.book-mark { text-decoration:  underline ;

             -webkit-text-decoration-style: wavy;

             text-decoration-style: wavy;}

```

例：

```html

<span class="book-mark”>論語</span>中記載

```

### 圖片

備註：

於`<img>`中加入class。基於HTML 5的規則，若出版社沒有要求的話，則必須加入`alt=""`

**HTML元素**

```html

<img src="../image/圖檔名" alt="替代文字">

```

・一般圖片

例：文中的圖片

```html

這段字是<img src="../image/gaiji-001.png" alt=""/>範本。

```

・缺字圖片

備註：

* Unicode Ext-B之後不在HKSCS內的漢字，一律以圖片顯示

* 要以哪款字型製作圖片，依照出版社指示

* 背景為白色或者透明，請以8bit PNG格式保存

**CSS Class**

```css

class="gaiji"      ： 縦横１字大小的圖片           （圖片尺寸範例：128px×128px）

class="gaiji-line" ： 寬１字的縦長圖片         （圖片尺寸範例：寬128px×高自由）

class="gaiji-wide" ： 高１字的横長圖片         （圖片尺寸範例：高128px×寬自由）

```

・指定圖片尺寸

備註：尺寸可以文字數或者對螢幕的比例來指定。

若用於行內（inline）顯示的圖片，基本上請以文字數來指定。能指定的文字數請參考CSS。若圖片太大卻不指定`max-`時，可能會切出螢幕或者變形。

**CSS Class**

```css

height-*em       ： 圖片高度以文字數指定（例「height-2em50」……高2.5字）

height-***per    ： 圖片高度以螢幕高度比例指定

                   （例「height-010per」……高為螢幕高度的10%）

max-height-*em   ： 圖片高度的最大值以文字數指定

max-height-***per： 圖片高度的最大值以螢幕高度比例指定

width-*em        ： 圖片的寬度以文字數指定

width-***per     ： 圖片的寬度以螢幕寬度比例指定

max-width-*em    ： 圖片寬度的最大值以文字數指定

max-width-***per ： 圖片寬度的最大值以螢幕高度比例指定

max-size-*em     ： 圖片的高度與寬度的最大值以文字數指定

max-size-***per  ： 圖片的高度與寬度以螢幕高度與寬度的比例指定

```



＊其他auto, none, 0等可以利用的值請參照後面「box處理」的「size」項目

例：將圖片縮小用於內文，高2.5行

```html

這段字是<img class="height-2em50" src="../image/gaiji-0001.png" alt=""/>範本。

```

．整頁圖片

備註：可配合螢幕尺寸伸縮。但圖片不會放大到原尺寸以上。整頁圖片的尺寸設定上`max-`請設定為`％`。以文字數指定的圖片不能放大為整頁圖片。

**CSS class**

```css

class="fit" ： 設定圖片為整頁圖片

```

例：頁面高與寬100%

```html

<p><img class="fit" src="../image/img-001.jpg" alt=""/></p>

```

例：以頁面的50%高度顯示

```html

<p><img class="fit max-height-050per" src="../image/img-001.jpg" alt=""/></p>

```

例：以20字尺寸顯示（非整頁）

```html

<p><img class="fit max-height-20em" src="../image/img-001.jpg" alt=""/></p>

```

### 標題

備註：

若沒有特別指示的話，書名等使用以下標題元素，副標與接在標題之後的行，請使用`<p></p>`。各標題層級的標注方式，由各出版社提供指示進行；若沒有特別指定標題，由製作者自行判斷該使用哪些標題層級。

字體與文字尺寸等裝飾設定，標題與`<div>`一樣視為區塊元素。但標題元素中不能再使用`<div>`或`<p>`元素，請多注意。

位置調整與縮排等，請將標題元素以`<div>`包覆；該`<div>`內除了標題元素外，可以再加入其他元素。

**HTML元素**

```html

<h1>〜<h6>

```

例：裝飾標題文字

```html

<h1 class="gfont font-1em30">第一章</h1>

```

例：標題縮排四字

```html

<div class="h-indent-4em">

    <h1>第一章 標題</h1>

    <p>副標等</p>

</div>

```

・標題使用的空Class

備註：CSS檔案中準備了供標題使用的空Class。可以按照作品不同設定對應的樣式。CSS檔案的客製化方式，請見後面的「關於預設CSS檔案」。

**CSS Class**

```css

class="mokuji-midashi"

class="tobira-midashi"

class="oo-midashi"

class="naka-midashi"

class="ko-midashi"

```

例：指定標題用的Class

```html

<h1 class="oo-midashi">第一章</h1>

```

・標題圖片

備註：

當把標題做成圖片時，可以使用文內（inline）圖片或者整頁圖片。圖片可以使用標題元素（`<h1>~<h6>`）包覆。考量到朗讀與搜尋，請於圖片內插入標題文字於alt中。

例：標題圖片的基本型

```html

<p><img class="fit" src="../image/img-001.jpg" alt="第一章"/></p>

```

### 行內元素（inline）的位置對齊

・變更基線

備註：

直排時`vertical-align`的baseline居於中央。行之上邊，下邊依照RS不同會有不同的結果。

**CSS Class**

```css

class="valign-inherit"     ： 繼承母元素的vertical-align

class="valign-baseline"    ： 子元素的Baseline與母元素的baseline對齊

class="valign-middle"      ： 子元素的中央與母要素的middle baseline對齊

class="valign-top"         ： 子元素的上邊與行的上邊對齊

class="valign-bottom"      ： 子元素的下邊與行的下邊對齊

class="valign-text-top"    ： 子元素的上邊與母元素的文字上邊對齊

class="valign-text-bottom" ： 子元素的下邊與母元素的文字下邊對齊

class="valign-sub"         ： 位於母元素的下標字位置

class="valign-super"       ： 位於母元素的上標字位置

```

例：文字中央與母元素middle baseline（小寫「x」的中央位置）對齊

```html

文字x<span class="valign-middle">Ｘ</span>x文字

```

・上標字、下標字

備註：可以使用HTML中的`<sup></sup>`上標字與`<sub></sub>`下標字標籤，或者使用CSS Class來處理，兩者僅使用其中一種即可。

**HTML元素**

```html

<sup></sup>上標字

<sub></sub>下標字

```

**CSS Class**

```css

class="super"

class="sub"

```

例：上標字

```html

Ｈ<span class="super">２</span>Ｏ

Ｈ<sup>２</sup>Ｏ

```

例：下標字

```html

Ａ<span class="sub">Ｂ</span>Ｃ

Ａ<sub>Ｂ</sub>Ｃ

```

・小字

備註：

使用HTML元素中的`<small></small>`標注。或者使用CSS Class來處理，兩者僅使用其中一種即可。

**HTML元素**

```html

<small></small>

```

**CSS Class**

```css

class="kogaki"

```

### 行的對齊

備註：

若沒有特別的排版指示，在`<div>`中必須於原始碼中加入CSS語法調整對齊。如果希望行尾對齊螢幕尾端，請於`<body>`中的`text-align`設定為`justify`。但因為螢幕尺寸關係，如果英文單字較長，會出現較寬的字句。基本上不予修正。若需要調整，請將該行設定為`align-start`。

**CSS Class**

```css

class="align-start"   ： 對齊行首（直排對齊天，橫排對齊左端）

class="align-center"  ： 對齊行中

class="align-end"     ： 對齊行末（直排對齊地，橫排對齊右端）

class="align-justify" ： 對齊兩端（除最後一行外，對齊行兩端，自動調整字距）

```

例：對齊行末

```html

<div class="align-end">

    <p>文字</p>

    <p>文字</p>

</div>

```

### 縮排（indent）

・使用**全型空白**縮排

備註：縮排六字以上時，於較小的螢幕上換行可能會出現問題，盡量使用`start`。此外，使用整頁圖片（`class="fit"`）時，不可以使用全型空白縮排。

例：縮排四字※□⋯⋯全型空白

```html

<h1>□□□□標題文字</h1>

<p>□□□□內文字</p>

<p>□□□□<img src="../image/img-001.jpg" alt=""/></p>

<p>□□□□<img class="height-3em" src="../image/img-001.jpg" alt=""/></p>

```

・使用Class指定縮排

備註：由行首開始縮排，橫排時由左開始，直排時由天開始縮排。原則上在`<div>`的class中以`start-*em`指定縮排字數。此外，由於使用了margin進行調整，不建議於同一元素中使用margin調整留白。

**CSS Class**

```css

class="start-*em" （可使用”start-0"）

```

例：從行頭起一率縮排四字

```html

<div class="start-4em">

    <h1>標題文字</h1>

    <p>內文字</p>

    <p><img class="height-3em" src="../image/img-001.jpg" alt=""/></p>

    <p><img class="fit max-height-050per" src="../image/img-001.jpg" alt=""/></p>

</div>

```

・行尾縮排

備註：基本上與縮排相同，由行尾開始往上提數字。橫排時由右開始，直排時由地開始縮排。與縮排一樣，元素內不要使用margin進行調整。

**CSS Class**

```css

class="end-*em" （可使用”end-0"）

```

例：從行尾起一率縮排四字

```html

<div class="end-4em">

	<p>內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字</p>

</div>

```

・首行縮排

只有第一行進行縮排。橫排時由左開始，直排時由天開始縮排。

**CSS Class**

```css

class="indent-*em" （可使用”indent-0"）

```

例：每段落首行縮排二字

```html

<div class="indent-2em">

    <p>內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字</p>

    <p>內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字</p>

</div>

```

・首行凸排

備註：當換行時，指定換行後的開始位置。橫排時由左開始，直排時由天開始縮排。`h-`為`hanging-`的簡稱。但橫排時依照文字寬度可能會對不齊。CSS中使用負值的indent與padding來調整位置，所以不要於同一元素中使用padding調整。

**CSS Class**

```css

class="h-indent-*em" （可使用”h-indent—0”）

```

例：每段落首行縮排二字

```html

<div class="h-indent-2em">

    <p>男：內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字</p>

    <p>女：內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字</p>

</div>

```

實際排版顯示如下：

```html

  男：內文字內文字內文字內文字內文字內文字內文字內文

字內文字內文字內文字內文字內文字

  女：內文字內文字內文字內文字內文字內文字內文字內文

字內文字內文字內文字內文字內文字

```

與縮排並用

```html

<div class="start-2em h-indent-2em">

	<p>男：內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字內文字</p>

</div>

```

### 行距與字距

・行距

備註：

初期設定為1.75，若要透過margin等調整前後行的空白時，請考量到行距的值。當調整文字尺寸時，行距也會隨之調整，若沒有特別指示，由製作者自行判斷。因為會影響行距，所以原則上不調整行內的文字尺寸。

**CSS Class**

```css

class="line-height-normal" ： 行距按照RS預設值

class="line-height-*em"    ： 行距依照文字數量指定

```

例：行距為內文的一倍

```html

<div class="line-height-3em50">

	<p>□□內文內文內文內文內文內文內文內文內文內文內文內文內文內文內文內文內文內文內文內文內文內文內文內文內文內文。</p>

</div>

```

・字距

備註：字距原則上僅用於標題設計，不建議使用於內文中。字距不會反映在文字與圖片的間距上，當使用缺字圖片與行內圖片時盡量避免使用。同時進行縱中橫排時，縱中橫排的文字也會套用字距，盡量避免使用，或者在縱中橫的Class中將字距設定為0，但會造成縱中橫排的字與下方文字的字距也會為0。

**CSS Class**

```css

class="lspacing-normal" ： 字距按照RS預設值

class="lspacing-*em"    ： 字距依照文字數量指定（可為”lspacing—0）

```

例：標題內加入1/4字距

```html

<div class="lspacing-0em25">

	<h1>標題</h1>

</div>

```

・避頭點

備註：目前中文標點符號大致上會自動進行避頭點調整。CSS雖提供三種避頭點處理，但對中文影響甚少。不建議調整。

**CSS Class**

```css

class="line-break-auto"   ： 避頭點按照RS預設值

class="line-break-loose"  ： 寬鬆的避頭點規則

class="line-break-normal" ： 標準避頭點規則

class="line-break-strict" ： 嚴格的避頭點規則

```

・自動換行規則

備註：當文字排到行尾時強制斷行。遇到連續符號，如「⋯⋯……」時，有時會因避頭點造成錯誤，也可使用該語法。

**CSS Class**

```css

class="word-break-normal"    ： 依標準規則換行

class="word-break-break-all" ： 可於任何位置斷行（遇到長單字時也會切斷換行）

class="word-break-keep-all"  ： 不會於英文單字中斷行（只會由空白或標點處換行）

```

例：

```html

<div class="word-break-break-all">

	<p>ABCDEFGHIJKLM NOPQRSTUVWXYZ abcdefghijklm nopqrstuvwxyz</p>

</div>

```

・長單字換行規則

備註：當遇到沒有空白的長西文單字（如德文），可以設定規則進行強制換行，使用的語法為`word-wrap-break-word`。本文件的預設CSS就在Body中加入`{word-wrap: break-word; }`

**CSS Class**

```css

class="word-wrap-normal"     ： 依標準規則換行

class="word-wrap-break-word" ： 遇到長單字時，於任何段落換行

```

例：

```html

<div class="word-wrap-break-word">

	<p>http://abcdefghijklmnopqrstuvwxyz.html</p>

</div>

```

・間隔線

**HTML元素**

```html

<hr/> ： 間隔線（橫排時為水平，直排時為垂直）

```

例：

```html

<p>文字</p>

<hr/>

<p>文字</p>

```

・間隔符號

備註：

若沒有特別指示，縮排使用全型空白。

例：

```html

<p>文字</p>

<p>□□□□＊</p>

<p>文字</p>

```

・間隔圖片（以一般圖片處理）

備註：

若無特別指示，圖片以原尺寸處理，縮排使用全型空白。但實務上建議以文字數指定圖片寬度。

例：縮排四字，寬為一字寬

```html

<p>文字</p>

<p>□□□□<img class="width-1em” src="../image/img-001.jpg" alt=""/></p>

<p>文字</p>

```

### 連結

備註：

連結位置所在元素，原則上需要加上id。

・到檔案開頭的連結

**HTML元素**

```html

<a href="要連結的檔案名稱">連結文字</a>

```

例：到「p-002.xhtml」的開頭位置

```html

<a href="p-002.xhtml">連結到其他檔案</a>

```

・頁面內的連結

**HTML元素**

```html

<a href="#id">連結文字</a> ： 指定連結方

<span id="id">連結目標</span> ： 連結目標方（可以為 <div> 或 <p>、<a>、<h1>〜<h6> 等）

```

例：連結到「id="link-001」

```html

<p><a href="#link-001">連結到內容</a></p>

<p id="link-001">內容的本文</p>         // 連結到段落開頭

<p>内容的本文<span id="link-001">連結文字</span>内容的本文</p> // 跳到段落中的一處

```

・連結到其他檔案的任意一處

**HTML元素**

```html

<a href="連結到的檔案名稱#id">連結文字</a> ： 指定連結方

<span id="id">連結目標</span>      ： 連結目標方（可以為 <div> 或 <p>、<a>、<h1>〜<h6> 等）

```

例：連結到「p-002.xhtml內的「id="toc-001”」」位置

```html

<p><a href="p-002.xhtml#toc-001">到標題的連結</a></p>

<h1 id="toc-001">標題</h1>

```

・相互連結

**HTML元素**

```html

<p><a id="link-001" href="檔案名稱#link-002">連結１</a></p> ： 連結１

（跳到連結2的位置）

<p><a id="link-002" href="檔案名稱#link-001">連結２</a></p> ： 連結２

（跳到連結1的位置）

```

・註釋

備註：為了點擊方便，標注時除了註釋符號以外，建議也將註釋的單字也透過連結一併指定。若不曉得注視的範圍為何，請指定適當的範圍。

**CSS Class**

```css

class="noteref"         ： 預設為藍色文字，有旁線

class="note"          ： 預設為藍色文字，有旁線

class="footnote"        ： 無特別樣式（「footnote」為「脚註」的意思）

class="super"          ： 指定為上標字（參考「上標字、下標字」項目）※這裡用於註解記號

```

**HTML元素**

```html

<p><a epub:type="noteref" class="noteref"  href="檔案名稱#註解編號" rel="footnote" ><sup>1</sup></a>：內文註解記號（註解記號部分可用<span>自行調整樣式）

<div epub:type="footnote" class="footnote" id="註解編號">

	<p>注釋內容中的一個段落。</p>

</div>：註解內容

```

雙向註解為

```html

<a epub:type="noteref" class="noteref" id="位置編號" href="#註解編號" rel="footnote" ><sup>1</sup></a>：內文註解記號（註解記號部分可用<span>自行調整樣式）

<div epub:type="footnote" class="footnote" id="註解編號">

    <p>注釋內容中的一個段落。</p>

    <a href="#位置編號">返回符號</a>

<div>：註解內容

```

### 處理Box元素

・Box的種類

**CSS Class**

```css

class="display-none"         : 將元素指定為 { display: none; } 

class="display-inline"       : 將元素指定為 { display: inline; } 

class="display-inline-block" : 將元素指定為 { display: inline-block; } 

class="display-block"        : 將元素指定為 { display: block; } 

```

例：讓一部份文字不顯示

```html

<p>一二三四五<span class="display-none">六七八九十</span>甲乙丙丁戊</p>

```

・外側邊界（Margin）

**CSS Class**

```css

class="m-*"

```

數值詳細

```css

m-auto / m-0 / m-***per / m-*em ： 指定四方邊界（可指定為auto、0、％、文字數）

m-top-auto    / m-top-0    / m-top-***per    / m-top-*em    ： 指定畫面上方邊界

m-bottom-auto / m-bottom-0 / m-bottom-***per / m-bottom-*em ： 指定畫面下方邊界

m-right-auto  / m-right-0  / m-right-***per  / m-right-*em  ： 指定畫面右方邊界

m-left-auto   / m-left-0   / m-left-***per   / m-left-*em   ： 指定畫面左方邊界

m-start-auto  / m-start-0  / m-start-***per  / m-start-*em  ： 指定行首邊界

m-end-auto    / m-end-0    / m-end-***per    / m-end-*em    ： 指定行尾邊界

m-before-auto / m-before-0 / m-before-***per / m-before-*em ： 指定行前邊界

m-after-auto  / m-after-0  / m-after-***per  / m-after-*em  ： 指定行後邊界

```

例：四邊各加兩文字邊界

```html

<div class="m-2em">

	<p>文字</p>

</div>

```

例：左右邊界為三行（當行距為1.75時）

```html

<div class="m-right-5em25 m-left-5em25">

	<p>文字</p>

</div>

```

・內側的留白（Padding）

**CSS Class**

```css

class="p-*"

```

數值詳細

```css

p-0 / p-***per / p-*em ： 指定四方內側留白（可指定為auto、0、％、文字數）

p-top-0    / p-top-***per    / p-top-*em    ： 指定畫面上方內側留白

p-bottom-0 / p-bottom-***per / p-bottom-*em ： 指定畫面下方內側留白

p-right-0  / p-right-***per  / p-right-*em  ： 指定畫面右方內側留白

p-left-0   / p-left-***per   / p-left-*em   ： 指定畫面左方內側留白

p-start-0  / p-start-***per  / p-start-*em  ： 指定行首內側留白

p-end-0    / p-end-***per    / p-end-*em    ： 指定行尾內側留白

p-before-0 / p-before-***per / p-before-*em ： 指定行前內側留白

p-after-0  / p-after-***per  / p-after-*em  ： 指定行後內側留白

```

例：四邊各留二字份空白

```css

<div class="p-2em">

    <p>文字</p>

</div>

```

・尺寸

備註：

當指定行長與行寬方向的尺寸時，請注意固定值與最大值不可以於同一元素內指定（當改變排版方向時，必須要清除一邊的尺寸）。若不會切換直排與橫排，也不會有橫排與直排混排的狀況發生時，才可以指定寬與高的尺寸。

※如以下案例採雙層結構時，就可以同時指定行長與行寬方向。但請不要期待往行寬方向（頁面進行方向）的表現會符合預期，最好讓文字自然排列。

```css

<div class="measure-10em">

    <div class="extent-5em25">

        <p>内容</p>

    </div>

</div>

```

**CSS Class**

```css

class="height-*"

class="width-*"

class="measure-*"

class="extent-*"

class="max-height-*"

class="max-width-*"

class="max-measure-*"

class="max-extent-*"

class="max-size-*"

```

數值詳細

```css

height-auto / height-***per / height-*em ： 指定高度

width-auto  / width-***per  / width-*em  ： 指定寬度

measure-auto     / measure-***per     / measure-*em     ： 指定行長方向尺寸

extent-auto      / extent-***per      / extent-*em      ： 指定行寬方向尺寸

max-height-none  / max-height-***per  / max-height-*em  ： 指定高的最大值

max-width-none   / max-width-***per   / max-width-*em   ： 指定寬的最大值

max-measure-none / max-measure-***per / max-measure-*em ： 指定行長方向的最大值

max-extent-none  / max-extent-***per  / max-extent-*em  ： 指定行寬方向的最大值

max-size-none    / max-size-***per    / max-size-*em    ： 同時指定寬與高的最大值

```

例：高10文字，寬5行（行距1.75時）

```css

<div class="height-10em width-8em75">

    <p>文字</p>

</div>

```

### 框線

・四方框線

備註：若對整頁圖片指定，框線會溢出頁面外。所以整頁圖片不得指定框線。

**CSS Class**

```css

class="k-solid"  ： 實心框線

class="k-dotted" ： 點線框線

class="k-double" ： 雙線框線

class="k-dashed" ： 虛線框線

class="k-solid-black"  ： 實心框線（黒色）

class="k-solid-gray"   ： 實心框線（灰色）

class="k-solid-silver" ： 實心框線（銀色）

class="k-solid-white " ： 實心框線（白色）

```

例：為行內元素加上四方框線

```html

<p>一二三四五<span class="k-solid">六七八九十</span>甲乙丙丁戊</p>

```

例：為區塊元素加上四方框線

```html

<div class="k-solid">

    <p>文字</p>

</div>

```

・邊線

**CSS Class**

線種

```css

class="k-solid-*"  ： 實心線

class="k-dotted-*" ： 點線

class="k-double-*" ： 雙重

class="k-dashed-*" ： 虛線

```

數值詳細

```css

※螢幕上/下/右/左/上下/左右

k-solid-top  / k-solid-bottom  / k-solid-right  / k-solid-left / k-solid-topbottom  / k-solid-rightleft

k-dotted-top / k-dotted-bottom / k-dotted-right / k-dotted-left / k-dotted-topbottom / k-dotted-rightleft

k-double-top / k-double-bottom / k-double-right / k-double-left / k-double-topbottom / k-double-rightleft

k-dashed-top / k-dashed-bottom / k-dashed-right / k-dashed-left / k-dashed-topbottom / k-dashed-rightleft

※行首/行尾/行前/行後/行首尾/行前後

k-solid-start  / k-solid-end  / k-solid-before  / k-solid-after / k-solid-startend  / k-solid-beforeafter

k-dotted-start / k-dotted-end / k-dotted-before / k-dotted-after / k-dotted-startend / k-dotted-beforeafter

k-double-start / k-double-end / k-double-before / k-double-after / k-double-startend / k-double-beforeafter

k-dashed-start / k-dashed-end / k-dashed-before / k-dashed-after / k-dashed-startend / k-dashed-beforeafter

```

線寬

```css

class="k-*px"    ： 0.8px

class="k-thin"   ： 細線

class="k-medium" ： 中線

class="k-thick"  ： 太線

```

例：區塊元素加上4px左右框線

```html

<div class="k-solid-rightleft k-4px">

    <p>文字</p>

</div>

```

### 區塊元素的位置對齊

備註：

直排不能對齊左右、橫排不能對齊上下方向，請需注意。

**CSS Class**

```css

class="block-align-left"   ： 【橫排用】對齊螢幕左側畫面的左側

class="block-align-center" ： 【橫排用】螢幕左右中央

class="block-align-right"  ： 【橫排用】對齊螢幕右側

class="block-align-top"    ： 【直排用】對齊螢幕上方

class="block-align-middle" ： 【直排用】對齊螢幕正中央

class="block-align-bottom" ： 【直排用】對齊螢幕下方

class="block-align-start"  ： 行頭側

class="block-align-center" ： 行中央

class="block-align-end"    ： 行末側

```

例：四方加框高四字的Box位居行尾

```css

<div class="height-4em k-solid block-align-end">

    <p>範例文字</p>

</div>

```

### 同一檔案中的換頁

備註：

換頁考量到各RS的支援問題，原則上要換頁，就得更換檔案。但為了防止因此而增加檔案數量，當想要在相同檔案中強制換頁時，可以使用以下CSS Class換頁。但僅限於短文或者不需大幅變更檔案樣式時使用，現時點支援以下語法的RS有限，使用時必須注意。

**CSS Class**

```css

class="pagebreak"        ： 於指定區塊後換頁

class="pagebreak-before" ： 於指定區塊前換頁

class="pagebreak-both"   ： 於指定區塊前後換頁

```

例：語錄等一頁一行的內容，可於同一檔案中換頁

```html

<div class="pagebreak">

    <p>一二三四五六七</p>

</div>

<div class="pagebreak">

    <p>七六五四三二一</p>

</div>

```

### 指定色彩

備註：

若要追加其它色彩，請於CSS中增加Class。詳細請參照後面「關於預設CSS檔案」部份。此外，亮黃等色彩在灰階裝置上可能不容易顯示，請多加注意。

・文字色彩

**CSS Class**

```css

class="color-black"       : { color: #000000; }

class="color-dimgray"     : { color: #696969; }

class="color-gray"        : { color: #808080; }

class="color-darkgray"    : { color: #a9a9a9; }

class="color-silver"      : { color: #c0c0c0; }

class="color-gainsboro"   : { color: #dcdcdc; }

class="color-white"       : { color: #ffffff; }

class="color-transparent" : { color: transparent; }

class="color-red"         : { color: #ff0000; }

class="color-blue"        : { color: #0000ff; }

class="color-cyan"        : { color: #00ffff; }

class="color-magenta"     : { color: #ff00ff; }

class="color-orangered"   : { color: #ff4500; }

```

例：

```html

<p><span class="color-silver">文字</span></p>

<div class="color-silver">

	<p>文字</p>

	<p>文字</p>

</div>

```

・背景色

**CSS Class**

```css

class="bg-black"       : { background-color: #000000; }

class="bg-dimgray"     : { background-color: #696969; }

class="bg-gray"        : { background-color: #808080; }

class="bg-darkgray"    : { background-color: #a9a9a9; }

class="bg-silver"      : { background-color: #c0c0c0; }

class="bg-gainsboro"   : { background-color: #dcdcdc; }

class="bg-white"       : { background-color: #ffffff; }

class="bg-transparent" : { background-color: transparent; }

class="bg-red"         : { background-color: #ff0000; }

class="bg-blue"        : { background-color: #0000ff; }

class="bg-cyan"        : { background-color: #00ffff; }

class="bg-magenta"     : { background-color: #ff00ff; }

class="bg-orangered"   : { background-color: #ff4500; }

```

例：

```html

<p><span class="bg-silver">文字</span></p>

<div class="bg-silver">

    <p>文字</p>

    <p>文字</p>

</div>

```

・文字色彩反轉（黑白反轉）

**CSS Class**

```css

class="inverse"

```

例：

```html

<p><span class="inverse">文字</span></p>

<div class="inverse">

    <p>文字</p>

    <p>文字</p>

</div>

```

・框線色

**CSS Class**

```css

class="k-black"       : { border-color: #000000; }

class="k-dimgray"     : { border-color: #696969; }

class="k-gray"        : { border-color: #808080; }

class="k-darkgray"    : { border-color: #a9a9a9; }

class="k-silver"      : { border-color: #c0c0c0; }

class="k-gainsboro"   : { border-color: #dcdcdc; }

class="k-white"       : { border-color: #ffffff; }

class="k-transparent" : { border-color: transparent; }

class="k-red"         : { border-color: #ff0000; }

class="k-blue"        : { border-color: #0000ff; }

class="k-cyan"        : { border-color: #00ffff; }

class="k-magenta"     : { border-color: #ff00ff; }

class="k-orangered"   : { border-color: #ff4500; }

```

例：紅色框線

```html

<p><span class="k-solid k-red">文字/span></p>

<div class="k-solid k-red">

    <p>文字</p>

    <p>文字</p>

</div>

```

・連結色彩

備註：

可以透過編輯CSS進行客製化。詳細請參照後面「關於預設CSS檔案」



### 參考資料（本文件不推薦使用）

#### <u>文繞圖</u>

備註：文繞圖於部分RS上會出現排版錯誤，當文繞圖圖片多時，也會彼此影響，當在使用時請務必要於各RS上進行測試。

**CSS Class**

```css

class="float-none"        : 圖文分離

class="float-start"       : 圖片位於行首位置

class="float-end"         : 圖片位於行尾位置

class="float-clear"       : 解除文繞圖（ clear: both; ）

class="float-clear-start" : 解除行首位置文繞圖

class="float-clear-end"   : 解除行尾位置文繞圖

```

例：圖片位於行首側（圖片與文字間加上一字空白）

```html

<p><img class="float-start m-end-1em" src="../image/img-001.jpg" alt=""/></p>

<p>文字</p>

```

例：區塊元素位於行首側（元素與文字間加上一字空白）

```html

<div class="float-start m-end-1em">

    <p><img src="../image/img-001.jpg" alt=""/></p>

    <p>圖說</p>

</div>

<p>文字</p>

```

----



## 關於預設CSS檔案

### 樣式表組成

#### <u>文字重排型</u>

```

book-style.css                 ……XHTML所連結的檔案。

│                             讀取各CSS檔案以符合RS規格避免BUG

│                         也準備供各作品客製化的空間

│

│

│ /* 透過@import讀取以下的CSS檔案 */

│

├ style-reset.css            ……初始化用樣式表

│

├ style-standard.css         ……基本樣式表

│

├ style-advance.css          ……支援邏輯方向與排版方向轉換的樣式表（可不使用

│

├ (style-***.css)            ……出版社自用樣式表（各出版社須自行準備，需自付責任）

│

└ (style-check.css)          ……於Windows瀏覽器上直排時讓字型直立用於確認的樣式表

                          （上架交貨時取消讀入）

```

#### <u>固定版面型</u>

> TODO: 修正為 `-tw` 的版本

```

fixed-layout-jp.css            ……XHTML所連結的檔案。

                               固定版面不支援@import也沒關係

                                  不使用其他樣式表

```

### CSS檔案的使用規則

#### <u>支援`@import`讀入CSS</u>

範本為了讓XHTML檔案的內容能夠統一，XHTML側僅會讀入主要CSS，然後將其他CSS透過主要CSS以`@import`規則讀入。

但根據頁面不同，想要調整CSS時（例如要使用全客製化的CSS），則不在此限。

#### <u>原則上不調整預設CSS</u>

原則上不修改範本中的CSS。

當要變更數值時，請於`book-style.css`末的客製化空間，或者出版社自行準備樣式表予以覆蓋。

#### <u>修改、新增請自行負責</u>

本文件不使用複雜排版會用到的CSS，如果要進行以下調整，請自行進行檢查確認。

* 修改Class所設定的值

* 於Class中新增語法

* 未調整優先順序，修改記載位置

* 修改與其他Class連動的Class名稱

* 新增Class

* 新增出版社自己的樣式表


可以將不需要的Class刪除讓檔案縮小，註解行使用自動化刪除也不會影響動作，但請注意不要將使用到的Class等刪除。

#### <u>避免id重複</u>

id只要在各XHTML檔案中不重複的話就沒問題，但考量到EPUB中有多數XHTML檔案，建議使用不重複的id。

#### <u>製作或追加固定Class</u>

概要：

縮排或者尺寸指定等一部份樣式表，可能會遇到預設值不足的狀況，畢竟無法窮舉，在預設表中僅使用到常用的值而已。

例如調整字體尺寸，最大僅到300%，若要使用400%等不在預設值的數值，則需要自己新增逾樣式表中。

當新增數量不多時，請使用`book-style.css`裡的「作品特有客製化空間」。

當使用固定Class時，請使用既有的Class與語法，修改數值即可。未來在修改調整時，對方也可以一目了然知道該怎麼調整。

當新增數量多，或者想要使用於多數作品時，請準備自有的樣式表，於`book-style.css`中透過`@import`讀入。

例如版權頁、系列頁等會固定使用頁面專用的Class，建議使用獨立的CSS檔案進行管理。

#### <u>固定Class的種類</u>

##### <u>Ａ・不分直橫排，內容不需要修改的項目</u>

如字型大小與色彩指定等，無論直排與橫排都使用相同的語法。例如在`style-standard.css`中的字型尺寸語法為：

```css

.font-1em20 { font-size: 1.20em; }

```

像是1.25em等，需要用到不在範本中的尺寸時，可以如下面僅修改class名與值為尺寸數，建立新的Class來使用。

```css

/* -------------------------------------------------------------

 * 作品專屬客製化區塊

 * ------------------------------------------------------------- */

.font-1em25 { font-size: 1.25em; }

```

小數點以下的值，請如上記一般到小數點後二位即可。由於Class名不能使用點號，所以整數值放在單位前，小數值放在單位後，沒有小數值時，請如下僅採用整數值作為Class名。

```css

.font-1em { font-size: 1.00em; }

```

當Class使用百分比時，請如下以三位數字並列來命名

```css

.font-085per { font-size: 85%; }

```

##### <u>Ｂ・隨直橫排而需要調整語法的項目</u>

例如首行凸排語法，直排時會使用到上方的padding，橫排時會使用到左方的padding，但可以透過相同的Class名稱通用於直橫排。以下為實際在`style-standard.css`裡的凸排語法。

```css

.hltr .h-indent-1em { text-indent: -1em; padding-left: 1em; }

.vrtl .h-indent-1em { text-indent: -1em; padding-top:  1em; }

```

針對橫排的語法請在Class前加上`.hltr`和半型空白，針對直排則是加上`.vltr`和半型空白。

##### <u>參考資料（本文件不推薦使用）</u>

##### <u>Ｃ・直排與橫排混排時的對應方法</u>

當直排與橫排混合顯示時，Ｂ的CSS會造成顯示結果不正確。

例如在橫排頁面裡頭加入直排的區塊時，使用上記凸排語法時，就會套用橫排用左邊的Padding與直排用的上方Padding。

為了解決這狀況，就需要刪除橫排用的左邊Padding。以下是當在橫排中有直排時，將左邊Padding指定為0；直排中有橫排時，將上方Padding指定為0的語法。

```css

.hltr .vrtl .h-indent-1em { padding-left: 0; }

.vrtl .hltr .h-indent-1em { padding-top:  0; }

```

但這種方法也有缺點。當想要在凸排以外指定左邊Padding時就會有問題。像這種狀況實際處理上，可以如下記一般，將凸排與Padding處理分在不同元素裡。

```html

<div class="p-top-2em">

    <div class="h-indent-1em">

        <p>文字</p>

    </div>

</div>

```

此外，如下記處理，一看不需要兩層`<div>`結構，但實際上橫排中的直排沒有問題，卻會造成直排中的橫排出現問題。

```css

.hltr .h-indent-1em  { text-indent: -1em; padding: 0 0 0 1em; }

.vrtl .h-indent-1em  { text-indent: -1em; padding: 1em 0 0 0; }

```

若改變上下行記載，就會變成橫排中的直排出問題。因為後面的樣式優先於前面的樣式，是CSS的基本規則。

同樣的理由，使用本文件預設CSS，就算使用兩層`<div>`，也會出現問題。

無論如何都要使用直橫混排時，請進行充分的檢查。

除了凸排案例以外，縮排與行尾縮排，邊界、內部邊界、框線等具邏輯方向的class和線條等，在切換直橫混排時，都可能出現問題。

### 客製化

在`.book-style.css`中，已經準備好幾個可以修改的class和空Class。

以下案例為想要刪除連結旁線段的語法。

```css

/* 基本設定（上：横排 下：直排） */

.hltr a {

}

.vrtl a {

}

```

```css

/* 基本設定（上：横排 下：直排） */

.hltr a {

  text-decoration: none;

}

.vrtl a {

  text-decoration: none;

}

```

當對應直橫混合時，請在註解中追記處理方式。

當使用空Class時，請務必要在各RS上進行測試。若希望在大多數的RS上能夠安全顯示，請使用本文件預設的CSS進行組合，也建議不要設定得太過於複雜。

此外於測試時，可能如以下案例般，讓預設的CSS蓋過在`book-style.css`客製化區塊中定義的好字體與文字尺寸的Class，造成無法如預期般顯示。當使用客製化的Class時，請盡量不要使用其他的Class。

```html

.hltr .oo-midashi {

  font-size: 1.5em;

}

.vrtl .oo-midashi {

  font-size: 1.5em;

}

<h1 class="oo-midashi font-100per">標題</h1>

```

### 製作自有的CSS

基本上應存為UTF-8（無BOM）編碼，檔案開頭請務必要加入`@Charset "UTF-8”;`

----


## 致謝和貢獻者

本文件是由台灣數位出版聯盟取得日本電子書出版社協會（電書協）授權，以電書協之EPUB 3制作指引為基礎，召集國內多家電子書平台業者與出版社成立工作小組共同討論並加入台灣之產業需求以編撰完成。本文件得以完成需特別感謝以下所有機關、單位與個人之協助：
- 參與工作小組之相關平台與出版業者（按中文筆劃排序）
  - 台灣漫讀股份有限公司（BOOKWALKER）
  - 城邦出版集團（cité）
  - 春水堂科技娛樂股份有限公司（Hami）
  - 凌網科技股份有限公司（HyRead）
  - 博客來數位科技股份有限公司（books.com.tw）
  - 湛天創新科技股份有限公司（ Pubu）
  - 群傳媒股份有限公司（Readmoo）
  - 樂天Kobo（台灣）（Rakuten Kobo）
- 中華民國文化部
- 日本電子書籍出版社協会 (EBPAJ)
- 台灣數位出版聯盟 (TDPF)
- 臺灣電子書協會
- 萩野正昭（VOYAGER Japan, Inc.）

此外，在本文件之編撰過程中，亦得助於以下貢獻者的協助與建議（按中文姓名筆劃排序）：
- 杜偉漢（湛天創新科技股份有限公司）
- 林家賢（春水堂科技娛樂股份有限公司）
- 施性吉（台灣漫讀股份有限公司）
- 胡惠君（Rakuten Kobo Inc.）
- 張育瑋（凌網科技股份有限公司）
- 莊慧文（博客來數位科技股份有限公司）
- 許雅婷（Rakuten Kobo Inc.）
- 黃朝群（博客來數位科技股份有限公司）
- 葉文熙（群傳媒股份有限公司）
- 董福興（汪達數位出版股份有限公司）
- 劉又潔（博客來數位科技股份有限公司）
- 蔡競賢（湛天創新科技股份有限公司）
- 蕭中男（城邦出版集團）
- 郭書廷（湛天創新科技股份有限公司）
- Zheng（Jeff） Xu（Rakuten Kobo Inc.）
