<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<div id="fv-chatbot-button">
    <span>🤖</span>
</div>

<div id="fv-chatbot-panel">
    <div id="fv-chatbot-header">
        <div>
            <div class="fw-bold">FoodVerse Assistant</div>
            <small>Database-aware help</small>
        </div>
        <button type="button" id="fv-chatbot-close">×</button>
    </div>
    <div id="fv-chatbot-messages">
        <div class="fv-chatbot-bot">
            Hi, I can help you find restaurants, food items, and order details.
        </div>
    </div>
    <div id="fv-chatbot-suggestions">
        <button type="button" class="fv-chatbot-chip" data-prompt="Show best restaurants">Best restaurants</button>
        <button type="button" class="fv-chatbot-chip" data-prompt="Recommend pizza">Pizza</button>
        <button type="button" class="fv-chatbot-chip" data-prompt="My order status">Order status</button>
        <button type="button" class="fv-chatbot-chip" data-prompt="Payment help">Payment help</button>
    </div>
    <div id="fv-chatbot-footer">
        <input type="text" id="fv-chatbot-input" placeholder="Ask about food, restaurants, or orders">
        <button type="button" id="fv-chatbot-send">Send</button>
    </div>
</div>

<style>
#fv-chatbot-button{position:fixed;right:24px;bottom:24px;z-index:9999;width:64px;height:64px;border-radius:50%;border:none;background:linear-gradient(135deg,#f97316,#fb7185);color:#fff;font-size:28px;box-shadow:0 18px 40px rgba(15,23,42,.25);display:grid;place-items:center;cursor:pointer}
#fv-chatbot-panel{position:fixed;right:24px;bottom:96px;width:360px;max-width:calc(100vw - 32px);height:520px;background:#fff;border-radius:24px;box-shadow:0 25px 70px rgba(15,23,42,.24);z-index:9999;display:none;flex-direction:column;overflow:hidden}
#fv-chatbot-header{background:linear-gradient(135deg,#111827,#f97316);color:#fff;padding:16px 18px;display:flex;justify-content:space-between;align-items:center}
#fv-chatbot-close{border:none;background:rgba(255,255,255,.18);color:#fff;width:36px;height:36px;border-radius:50%;font-size:24px;line-height:1}
#fv-chatbot-messages{flex:1;padding:16px;overflow-y:auto;background:#f8fafc;display:flex;flex-direction:column;gap:10px}
.fv-chatbot-bot,.fv-chatbot-user{max-width:82%;padding:12px 14px;border-radius:18px;line-height:1.5;font-size:14px}
.fv-chatbot-bot{background:#fff;align-self:flex-start;box-shadow:0 6px 20px rgba(15,23,42,.08)}
.fv-chatbot-user{background:linear-gradient(135deg,#f97316,#fb7185);color:#fff;align-self:flex-end}
#fv-chatbot-suggestions{padding:12px;display:flex;flex-wrap:wrap;gap:8px;background:#fff;border-top:1px solid #e5e7eb}
.fv-chatbot-chip{border:none;background:#f1f5f9;color:#0f172a;padding:8px 12px;border-radius:999px;font-size:13px}
#fv-chatbot-footer{padding:12px;background:#fff;border-top:1px solid #e5e7eb;display:flex;gap:8px}
#fv-chatbot-input{flex:1;border:1px solid #cbd5e1;border-radius:999px;padding:12px 14px;outline:none}
#fv-chatbot-send{border:none;background:#111827;color:#fff;border-radius:999px;padding:0 18px;font-weight:600}
@media(max-width:768px){#fv-chatbot-panel{right:12px;left:12px;width:auto;height:70vh;bottom:86px}}
</style>

<script>
(function(){
  const button = document.getElementById('fv-chatbot-button');
  const panel = document.getElementById('fv-chatbot-panel');
  const closeButton = document.getElementById('fv-chatbot-close');
  const sendButton = document.getElementById('fv-chatbot-send');
  const input = document.getElementById('fv-chatbot-input');
  const messages = document.getElementById('fv-chatbot-messages');
  const chips = document.querySelectorAll('.fv-chatbot-chip');
  const contextPath = '<%=request.getContextPath()%>';

  function appendMessage(text, role) {
    const bubble = document.createElement('div');
    bubble.className = role === 'user' ? 'fv-chatbot-user' : 'fv-chatbot-bot';
    bubble.textContent = text;
    messages.appendChild(bubble);
    messages.scrollTop = messages.scrollHeight;
  }

  function loadingBubble() {
    const bubble = document.createElement('div');
    bubble.className = 'fv-chatbot-bot';
    bubble.textContent = 'Typing...';
    bubble.dataset.loading = 'true';
    messages.appendChild(bubble);
    messages.scrollTop = messages.scrollHeight;
    return bubble;
  }

  async function sendMessage(text) {
    const clean = (text || '').trim();
    if (!clean) return;
    appendMessage(clean, 'user');
    input.value = '';
    const loading = loadingBubble();
    try {
      const body = new URLSearchParams();
      body.append('message', clean);
      const response = await fetch(contextPath + '/chatbot', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded;charset=UTF-8'
        },
        body: body.toString()
      });
      const data = await response.json();
      loading.remove();
      appendMessage(data.reply || 'I could not understand that.', 'bot');
    } catch (error) {
      loading.remove();
      appendMessage('Sorry, I could not reach the assistant right now.', 'bot');
    }
  }

  button?.addEventListener('click', () => {
    panel.style.display = panel.style.display === 'flex' ? 'none' : 'flex';
  });
  closeButton?.addEventListener('click', () => panel.style.display = 'none');
  sendButton?.addEventListener('click', () => sendMessage(input.value));
  input?.addEventListener('keydown', (event) => {
    if (event.key === 'Enter') {
      sendMessage(input.value);
    }
  });
  chips.forEach((chip) => {
    chip.addEventListener('click', () => sendMessage(chip.dataset.prompt));
  });
})();
</script>
