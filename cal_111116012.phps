<!--賴怡璇_111116012
操作說明：就是小算盤，根據選擇內容進行加減乘除以及根號(root)平方(square)與+/-切換，僅顯示輸入數字，當按運算子時顯示先前計算(執行根號或平方後，如果再按數字見他會直接取代平方or根號後的數值，模擬小算盤)
目前可執行， 支援小數&整數、歸零，可將運算子顯示在上方text中
依評分標準我會給100-->
<html>
<head>
    <title>PHP Calculator</title>
    <style>
        body{
            background-color:#f0f0f0:
        }
        .display{
            font-size:22px;
            text-align: right;
            width:360px ;
            height: 50px;
            margin-top:10px;
        }
        .operator{
            font-size:18px;
            text-align: right;
            width:360px ;
            height: 30px;
        }
        .buttons button {
            width : 80px;
            height:50px;
            text-align: center;
            font-size: 18px;
            margin-top:10px;
            margin-right:5px;
            margin-left:5px;
            
        }
    </style>
</head>
<body>
<?
    /*static $first= false;//前方動作是+-*\\/，使dsiplay下次開始使用button時，重新歸零
    static $opbug=false;//避免使用著連續按運算元多次導致bug
    static $firstOperator = null;//運算子
    static $firstOperand = 0.0;//運算元
    */
    //判断是否存在 Post 请求
    if ($_SERVER["REQUEST_METHOD"] == "POST") { 
        $button = $_POST["button"];
        $display = $_POST['display'];
        $first = $_POST['first'];
        $opbug = $_POST['opbug'];
        $firstOperator = $_POST['operator'];
        $firstOperand = $_POST['num1'];
    }

    

   if($_POST['display']==null){//最一開始
    $first= false;//前方動作是+-*/，使dsiplay下次開始使用button時，重新歸零
    $opbug=false;//避免使用著連續按運算元多次導致bug
    $firstOperator = null;//運算子
    $firstOperand = 0.0;//運算元
    $display = "0";
   }
    else if($button == "C"){
        $display = "0";
        $first = false;
        $firstOperator = null;
        $firstOperand=0.0;
    }
    else{
        if($button=="+"||$button=="-"||$button=="*"||$button=="/"||$button=="="){
            if($opbug)   $firstOperator = $button;//若重複按運算子，數值不改變只改儲存的運算子
            else{

                //第一次按運算子時，因前方沒有計算，不過提醒程式第一個運算子出現
                if($firstOperator == null||$firstOperator=="="){
                    $firstOperator = $button;
                    $firstOperand = $display;        
                }
                else{
                    
                    //進行運算子功能使用
                    if($firstOperator=="+"){
                        $firstOperand += $display;
                    }
                    else if($firstOperator=="-"){
                        $firstOperand -= $display;
                    }
                    else if($firstOperator=="*"){
                        $firstOperand *= $display;
                    }
                    else if($firstOperator=="/"){
                        $firstOperand /= $display;
                    }

                    //因為=只是將運算總結輸出，不具運算功能，所以可以視為無運算子(並將firsrOprand視為剛開始第一個數值)
                   $firstOperator = $button;

                    //顯示數值
                    $display = $firstOperand;
                }
                
                $first = true;//以儲存運算子
                $opbug = true;
            }

        }

        else{
            //執行根號
            if($button=="root"){
                $display = sqrt($display);
                $first = true;//因為如果執行根號或平方後，如果按數字見他會直接取代平方or根號橫的數值
            }
            //平方公式
            else if($button =="square"){
                $display = pow($display,2);
                $first = true;
            }
            //+-切換
            else if($button =="+/-"){
                $display *= -1;;
            }
            else if($button =="."){
                if($display==intval($display))
                    $display = $display.$button;
            }
            //當display不為0且前方不為運算子(也就是還在輸入數值)
            else if($display !== "0"&&$first == false)
                $display = $display.$button;//字串相連用.
            //當前方輸入是運算子或是display值為0(輸入0or最一開始)
            else if($first == true||$display==="0"){
                $display = $button;
                $first = false;
            }
            $opbug = false;//打數字所以運算子不重複
        }
    }
    ?>
    <center>
    <form action= "cal_111116012.php", method="post">
    <input type="text" name="operator" class="operator" value="<?echo $firstOperator?>" readonly/><br>
        <input type="text" name="display" class="display" value="<?echo $display?>" readonly/>
        <input type="hidden" name="num1" class="num1" value="<?echo $firstOperand?>"/><!--用hidden藏起來，用來保存值-->
        <input type="hidden" name="operator" class="operator" value="<?echo $firstOperator?>" />
        <input type="hidden" name="first" class="first" value="<?echo $first?>" />
        <input type="hidden" name="opbug" class="opbug" value="<?echo $opbug?>" />
        <div class="buttons">
            <table>
            <tr>
                <td><button type="submit" name="button" value="C">C</button></td>
                <td><button type="submit" name="button" value="square">square</button><!--平方--></td>
                <td><button type="submit" name="button" value="root">root</button><!--根號--></td>
                <td><button type="submit" name="button" value="/">/</button></td>
            </tr>
            <tr>
                <td><button type="submit" name="button" value="1">1</button></td>
                <td><button type="submit" name="button" value="2">2</button></td>
                <td><button type="submit" name="button" value="3">3</button></td>
                <td><button type="submit" name="button" value="*">*</button></td>
            </tr>
            <tr>
                <td><button type="submit" name="button" value="4">4</button></td>
                <td><button type="submit" name="button" value="5">5</button></td>
                <td><button type="submit" name="button" value="6">6</button></td>
                <td><button type="submit" name="button" value="-">-</button></td>
            </tr>
            <tr>
                <td><button type="submit" name="button" value="7">7</button></td>
                <td><button type="submit" name="button" value="8">8</button></td>
                <td><button type="submit" name="button" value="9">9</button></td>
                <td><button type="submit" name="button" value="+">+</button></td>
            </tr>
            <tr>    
                <td><button type="submit" name="button" value="+/-">+/-</button></td>
                <td><button type="submit" name="button" value="0">0</button></td>
                <td><button type="submit" name="button" value=".">.</button></td>
                <td><button type="submit" name="button" value="=">=</button></td>
            </tr>
</table>
        </div>
    </form>
</center>
</body>
</html>

