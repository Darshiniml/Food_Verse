<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<!-- ================= FoodVerse AI ChatBot ================= -->

<div id="fv-ai-button">

    <div class="fv-ai-icon">

        🤖

    </div>

</div>

<div id="fv-ai-chat">

    <!-- Header -->

    <div id="fv-ai-header">

        <div class="fv-ai-profile">

            <div class="fv-ai-avatar">

                🤖

            </div>

            <div>

                <div class="fv-ai-title">

                    FoodVerse AI

                </div>

                <div class="fv-ai-status">

                    🟢 Online

                </div>

            </div>

        </div>

        <div class="fv-ai-actions">

            <button id="fv-ai-minimize">

                <i class="bi bi-dash-lg"></i>

            </button>

            <button id="fv-ai-close">

                <i class="bi bi-x-lg"></i>

            </button>

        </div>

    </div>

    <!-- Body -->

    <div id="fv-ai-body">

        <div class="fv-ai-bot">

            <div class="fv-ai-avatar-small">

                🤖

            </div>

            <div class="fv-ai-message">

                <h5>

                    Hello 👋

                </h5>

                <p>

                    I'm <b>FoodVerse AI</b>.

                    <br><br>

                    I can help you with

                </p>

                <ul>

                    <li>🍕 Food Recommendations</li>

                    <li>🍔 Restaurant Suggestions</li>

                    <li>📦 Order Tracking</li>

                    <li>💳 Payments</li>

                    <li>🚚 Delivery Status</li>

                    <li>❓ Customer Support</li>

                </ul>

            </div>

        </div>

    </div>

    <!-- Quick Suggestions -->

    <div id="fv-ai-suggestions">

        <button class="fv-suggestion">

            🍕 Recommend Pizza

        </button>

        <button class="fv-suggestion">

            🍔 Best Burger

        </button>

        <button class="fv-suggestion">

            📦 Track Order

        </button>

        <button class="fv-suggestion">

            💳 Payment Help

        </button>

    </div>

    <!-- Footer -->

    <div id="fv-ai-footer">

        <input

            type="text"

            id="fv-ai-input"

            placeholder="Ask FoodVerse AI..."

            autocomplete="off">

        <button id="fv-ai-send">

            <i class="bi bi-send-fill"></i>

        </button>

    </div>

</div>

<!-- =============================================== -->
<style>

/* ===========================
        FOODVERSE AI
=========================== */

:root{

--fv-primary:#ff6b35;
--fv-secondary:#ff8a00;
--fv-dark:#202124;
--fv-light:#ffffff;
--fv-bg:#f6f7fb;
--fv-shadow:0 20px 50px rgba(0,0,0,.18);

}

/* Floating Button */

#fv-ai-button{

position:fixed;

right:28px;

bottom:28px;

width:72px;

height:72px;

border-radius:50%;

background:linear-gradient(135deg,#ff6b35,#ff8a00);

display:flex;

justify-content:center;

align-items:center;

cursor:pointer;

box-shadow:var(--fv-shadow);

z-index:999999;

transition:.35s;

animation:floating 3s infinite;

}

#fv-ai-button:hover{

transform:scale(1.08);

}

.fv-ai-icon{

font-size:34px;

}

/* Chat Window */

#fv-ai-chat{

position:fixed;

right:28px;

bottom:115px;

width:400px;

height:650px;

background:white;

border-radius:25px;

display:none;

flex-direction:column;

overflow:hidden;

box-shadow:var(--fv-shadow);

z-index:999999;

animation:popup .35s;

}

/* Header */

#fv-ai-header{

background:linear-gradient(135deg,#ff6b35,#ff8a00);

padding:18px;

display:flex;

justify-content:space-between;

align-items:center;

color:white;

}

.fv-ai-profile{

display:flex;

align-items:center;

gap:15px;

}

.fv-ai-avatar{

width:52px;

height:52px;

border-radius:50%;

background:white;

display:flex;

justify-content:center;

align-items:center;

font-size:28px;

}

.fv-ai-title{

font-size:19px;

font-weight:700;

}

.fv-ai-status{

font-size:13px;

opacity:.9;

}

.fv-ai-actions button{

background:none;

border:none;

color:white;

font-size:20px;

cursor:pointer;

margin-left:8px;

}

/* Body */

#fv-ai-body{

flex:1;

padding:18px;

overflow-y:auto;

background:#f6f7fb;

scroll-behavior:smooth;

}

#fv-ai-body::-webkit-scrollbar{

width:6px;

}

#fv-ai-body::-webkit-scrollbar-thumb{

background:#d1d5db;

border-radius:20px;

}

/* Bot Bubble */

.fv-ai-bot{

display:flex;

align-items:flex-start;

margin-bottom:18px;

}

.fv-ai-avatar-small{

width:42px;

height:42px;

background:#ff6b35;

color:white;

border-radius:50%;

display:flex;

justify-content:center;

align-items:center;

margin-right:10px;

flex-shrink:0;

}

.fv-ai-message{

background:white;

padding:16px;

border-radius:18px;

max-width:85%;

box-shadow:0 4px 12px rgba(0,0,0,.08);

line-height:1.7;

}

.fv-ai-message h5{

margin-bottom:10px;

font-weight:700;

}

/* User Bubble */

.fv-user{

display:flex;

justify-content:flex-end;

margin:15px 0;

}

.fv-user .msg{

background:linear-gradient(135deg,#ff6b35,#ff8a00);

color:white;

padding:14px;

border-radius:18px 18px 0 18px;

max-width:80%;

box-shadow:0 4px 12px rgba(0,0,0,.1);

}

/* Suggestions */

#fv-ai-suggestions{

padding:12px;

display:flex;

flex-wrap:wrap;

gap:10px;

background:white;

border-top:1px solid #ececec;

}

.fv-suggestion{

border:none;

padding:10px 16px;

background:#f1f5f9;

border-radius:25px;

cursor:pointer;

transition:.25s;

font-size:14px;

}

.fv-suggestion:hover{

background:#ff6b35;

color:white;

}

/* Footer */

#fv-ai-footer{

padding:14px;

display:flex;

gap:10px;

background:white;

border-top:1px solid #ececec;

}

#fv-ai-input{

flex:1;

padding:14px;

border-radius:30px;

border:1px solid #d1d5db;

outline:none;

font-size:15px;

transition:.25s;

}

#fv-ai-input:focus{

border-color:#ff6b35;

}

#fv-ai-send{

width:54px;

height:54px;

border:none;

border-radius:50%;

background:linear-gradient(135deg,#ff6b35,#ff8a00);

color:white;

cursor:pointer;

font-size:20px;

transition:.25s;

}

#fv-ai-send:hover{

transform:scale(1.08);

}

/* Typing Animation */

.typing{

display:flex;

gap:6px;

padding:15px;

background:white;

width:70px;

border-radius:18px;

box-shadow:0 3px 10px rgba(0,0,0,.08);

margin-left:52px;

margin-bottom:18px;

}

.typing span{

width:8px;

height:8px;

background:#9ca3af;

border-radius:50%;

animation:typing 1.3s infinite;

}

.typing span:nth-child(2){

animation-delay:.2s;

}

.typing span:nth-child(3){

animation-delay:.4s;

}

/* Animations */

@keyframes floating{

0%,100%{

transform:translateY(0);

}

50%{

transform:translateY(-8px);

}

}

@keyframes popup{

from{

opacity:0;

transform:translateY(25px) scale(.9);

}

to{

opacity:1;

transform:translateY(0) scale(1);

}

}

@keyframes typing{

0%,80%,100%{

opacity:.3;

transform:translateY(0);

}

40%{

opacity:1;

transform:translateY(-5px);

}

}

/* Mobile */

@media(max-width:768px){

#fv-ai-chat{

width:95%;

right:2.5%;

left:2.5%;

height:80vh;

bottom:95px;

}

#fv-ai-button{

right:18px;

bottom:18px;

}

}

</style>