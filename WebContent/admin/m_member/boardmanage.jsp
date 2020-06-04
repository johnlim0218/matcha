<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>게시판 관리</title>
    <style>
        .list {
            color: black;
            font-family: monospace, monospace;
            margin: 10px 15px;
            box-sizing: border-box;
            padding: 20px 30px;
        }

        .list>a {
            text-decoration: none;
            color: rgba(12, 10, 10, 0.589);
        }

        .list>a:hover {
            text-decoration: underline;
        }

        .list>a:visited {
            color: rgba(12, 10, 10, 0.589);
        }

        .list1 {
            list-style-type: none;
            border-bottom: 1px solid #dddddd;
        }


        .subj {
            position: fixed;
            top: 0;
            right: 0;
            left: 0;
            margin: 0 auto;
        }

        .subjbox {
            margin: 0 auto;
            width: 300px;
            height: 48px;
        }

        .subjbox>h1 {
            text-align: center;
            background: #55ffaa;
            background: -webkit-linear-gradient(left, #55ff55, #ff5588);
            background: -moz-linear-gradient(right, #55ff55, #ff5588);
            background: -o-linear-gradient(right, #55ff55, #ff5588);
            background: linear-gradient(to right, #55ff55, #ff5588);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            font-size: 35px;
            font-weight: bold;
            padding: 0;
            margin: 10px;
        }

        .box {
            position: fixed;
            top: 0px;
            left: 0;
            z-index: 51;
            background: #fff;
            text-align: center;
            width: 100%;
            height: 72px;
            box-shadow: 0 1px 1px 0 rgba(0, 0, 0, 0.10), 0 0 0 0 #D2D2D2;
        }



        .pan0 {

            text-align: center;
        }

        .pan1 {
            margin: 0 20px;
        }

        .pan2 {
            list-style: none;
            padding: 0;
            margin: 0;
            overflow: hidden;
        }

        .logospot {
            float: left;
            margin: 28px 0px 0px;
        }

        .logo {
            display: block;
            width: 98px;
            height: 30px;
            background: URL(images/logo.png) center center / contain no-repeat;
        }

        .my {
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            -webkit-align-items: center;
            -webkit-box-align: center;
            -ms-flex-align: center;
            align-items: center;
            float: right;
            height: 74px;
            margin: 0 0 0 20px;
        }

        .my>a {
            text-decoration: none;
        }

        .userpicbox {
            display: block;
            border: solid 1px rgba(0, 0, 0, 0.08);
            border-radius: 50%;
            display: -webkit-box;
            display: -webkit-flex;
            display: -ms-flexbox;
            display: flex;
            position: relative;
            -webkit-box-pack: center;
            -webkit-justify-content: center;
            -ms-flex-pack: center;
            justify-content: center;
            -webkit-align-items: center;
            -webkit-box-align: center;
            -ms-flex-align: center;
            align-items: center;
            width: 56px;
            height: 56px;
            overflow: hidden;
            width: 32px;
            height: 32px;
            cursor: pointer;
        }

        .userpic {
            position: absolute;
            z-index: 1;
            background: url(images/user.png) no-repeat center;
            background-size: cover;
            width: 100%;
            height: 100%;
        }

        .mid {
            padding-top: 0px;
            padding-bottom: 48px;
        }

        .midheader {
            position: fixed;
            top: 0;
            left: 0;
            z-index: 50;
            background: #fff;
            box-sizing: border-box;
            font-size: 17px;
            font-weight: 700;
            -webkit-letter-spacing: -0.1px;
            -moz-letter-spacing: -0.1px;
            -ms-letter-spacing: -0.1px;
            letter-spacing: -0.1px;
            line-height: 22px;
            width: 100%;
            height: auto;
            padding: 0 16px;
            border-bottom: 1px solid #e3e3e3;
            top: 72px;
            text-align: left;
            height: auto;
        }

        .midheader:lang(ja),
        .midheader:lang(ko) {
            font-size: 17px;
            font-weight: 700;
            -webkit-letter-spacing: -0.5px;
            -moz-letter-spacing: -0.5px;
            -ms-letter-spacing: -0.5px;
            letter-spacing: -0.5px;
            line-height: 22px;
        }
    </style>
</head>

<body>
    <div>
        <header class="box">
            <nav>
                <div class="pan0">
                    <div class="pan1">
                        <ul class="pan2">
                            <li class="logospot">
                                <a href="#">
                                    <span src="images/logo.png" class="logo"></span>
                                </a>
                            </li>
                            <li class="my">
                                <a href="#">
                                    <div class="userpicbox">
                                        <div class="userpic"></div>
                                    </div>
                                </a>
                            </li>
                            <li class="my">
                                <a href="#">
                                    <div class="favorite"></div>
                                </a>
                            </li>
                        </ul>
                        <div class="subj">
                            <div class="subjbox">
                                <h1>게시판 관리</h1>
                            </div>
                        </div>
                    </div>
                </div>
            </nav>
        </header>
        <section>

            <div class="midheader">
                <div class="midblank">
                    <li class="list1">
                        <p class="list">
                            <a href="#">공지사항 관리</a>
                        </p>
                    </li>
                    <li class="list1">
                        <p class="list">
                            <a href="#">게시글 삭제</a>
                        </p>
                </div>
            </div>
    </div>
    </div>


    </section>


    </div>

</body>

</html>