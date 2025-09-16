<%-- 賴怡璇_111116012
操作說明：就是小算盤，根據選擇內容進行加減乘除以及根號(root)平方(square)與+/-切換，僅顯示輸入數字，當按運算子時顯示先前計算(執行根號或平方後，如果再按數字見他會直接取代平方or根號後的數值)
判斷輸出有無小數，無則顯示整數
目前可執行， 支援小數&整數、歸零
依評分標準我會給100--%>
<%@ page contentType=" text/html;charset=UTF-8"
    language="java" 
    import= "java.util.*"%>

<%!

    boolean first = false;//前方動作是+-*/，使dsiplay下次開始使用button時，重新歸零
    boolean opbug=false;//避免使用著連續按運算元多次導致bug
    String firstOperator = " ";//運算子
    Double firstOperand=0.0;//運算元
%>
<%
    String display = request.getParameter("display");
    String button = request.getParameter("button");
    if(display == null){
        display = "0";
        button = "";
    }
	else if(button.equals("C")){
        display="0";
        button="";
        first = false;
        firstOperator = " ";
        firstOperand=0.0;
    }
	else{
        char[] input = button.toCharArray();
        if(input[0]<='9' &&input[0]>='0'||button.equals("root")||button.equals("square")||button.equals("+/-")||button.equals(".")){
            //執行根號
            if(button.equals("root")){
                 Double ans = Math.sqrt(Double.parseDouble(display));
                //顯示數值
                    if(ans%1 != 0)//小數結果
                        display = Double.toString(ans);
                    //整數結果
                    else{
                        display = Integer.toString(ans.intValue());
                    }
                first = true;//因為如果執行根號或平方後，如果再按數字見他會直接取代平方or根號後的數值
            }
            //平方公式
            else if(button.equals("square")){
                Double ans = Math.pow(Double.parseDouble(display),2);
                //顯示數值
                    if(ans%1 != 0)//小數結果
                        display = Double.toString(ans);
                    //整數結果
                    else{
                        display = Integer.toString(ans.intValue());
                    }
                first = true;//因為如果執行根號或平方後，如果再按數字見他會直接取代平方or根號橫的數值
            }
            //+-切換
            else if(button.equals("+/-")){
                Double ans = Double.parseDouble(display)*-1;
                if(ans%1 != 0)//小數結果
                        display = Double.toString(ans);
                    //整數結果
                    else{
                        display = Integer.toString(ans.intValue());
                    }
            }
            //加小數點
            else if(button.equals(".")){
                if(Double.parseDouble(display)%1 == 0){
                    display = display + button;
                }
            }
            //當display不為0且前方不為運算子(也就是還在輸入數值)
            else if(!display.equals("0")&&first == false)
		        display = display + button;
            //當前方輸入是運算子或是display值為0(輸入0or最一開始)
            else if(first == true||display.equals("0")){
                display = button;
                first = false;
            }
            opbug = false;//打數字所以運算子不重複
        }
        else{
            if(opbug)   firstOperator = button;//若重複按運算子，數值不改變只改儲存的運算子
            else{
                //第一次按運算子時，因前方沒有計算，不過提醒程式第一個運算子出現
                if(firstOperator == " "||firstOperator.equals("=")){
                    firstOperator = button;
                    firstOperand = Double.parseDouble(display);
                    
                }
                else{
                    
                    //進行運算子功能使用
                    if(firstOperator.equals("+")){
                        firstOperand += Double.parseDouble(display);
                    }
                    else if(firstOperator.equals("-")){
                        firstOperand -= Double.parseDouble(display);
                    }
                    else if(firstOperator.equals("*")){
                        firstOperand *= Double.parseDouble(display);
                    }
                    else if(firstOperator.equals("/")){
                        firstOperand /= Double.parseDouble(display);
                    }
                    
                    //因為=只是將運算總結輸出，不具運算功能，所以可以視為無運算子(並將firsrOprand視為剛開始第一個數值)
                    firstOperator = button;

                    //顯示數值
                    if(firstOperand%1 != 0)//小數結果
                        display = Double.toString(firstOperand);
                    //整數結果
                    else{
                        int inp = firstOperand.intValue();
                        display = Integer.toString(inp);
                    }
                }
                first = true;//以儲存運算子
                opbug = true;
            }

        }
        
        
	}
%>   
<html>
<head>
    <title>JSP Calculator</title>
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
    <center>
        <form action= "cal_111116012.jsp", method="post">
        <input type="text" name="operator" class="operator" value="<%= firstOperator %>" readonly/><br>
            <input type="text" name="display" class="display" value="<%= display %>" readonly/>
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


