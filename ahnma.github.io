<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>نظام حساب اللكعة وتفريغ الحمل الشامل</title>
    <style>
        :root {
            --bg: #f8fafc;
            --card: #ffffff;
            --text: #0f172a;
            --text-secondary: #64748b;
            --border: #e2e8f0;
            --primary: #2563eb;
            --safe-bg: #ecfdf5;
            --safe-border: #10b981;
            --safe-text: #065f46;
            --danger-bg: #fef2f2;
            --danger-border: #ef4444;
            --danger-text: #991b1b;
            --accent: #f1f5f9;
            --reefer-color: #0284c7;
        }

        body.dark-theme {
            --bg: #0f172a;
            --card: #1e293b;
            --text: #f8fafc;
            --text-secondary: #94a3b8;
            --border: #334155;
            --safe-bg: #064e3b;
            --safe-border: #34d399;
            --safe-text: #a7f3d0;
            --danger-bg: #7f1d1d;
            --danger-border: #f87171;
            --danger-text: #fca5a5;
            --accent: #334155;
        }

        * { box-sizing: border-box; font-family: system-ui, -apple-system, blinkmacsystemfont, 'Segoe UI', roboto, sans-serif; margin: 0; padding: 0; transition: background-color 0.2s, color 0.2s, border-color 0.2s; }
        body { background-color: var(--bg); color: var(--text); padding: 24px 12px; display: flex; justify-content: center; align-items: flex-start; min-height: 100vh; }
        
        .container { 
            background-color: var(--card); 
            padding: 32px; 
            border-radius: 24px; 
            width: 100%; 
            max-width: 680px; 
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.04);
            border: 1px solid var(--border);
        }

        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 1px solid var(--border); padding-bottom: 16px; }
        .header h2 { font-size: 20px; font-weight: 800; }

        .theme-btn { 
            background: var(--accent); 
            border: 1px solid var(--border); 
            padding: 8px 16px; 
            border-radius: 30px; 
            cursor: pointer; 
            color: var(--text); 
            font-size: 13px;
            font-weight: 600;
        }

        .tabs { display: flex; gap: 8px; margin-bottom: 20px; background: var(--accent); padding: 4px; border-radius: 14px; }
        .tab-btn { 
            flex: 1; 
            padding: 10px; 
            border: none; 
            background: transparent; 
            color: var(--text-secondary); 
            font-weight: 700; 
            font-size: 14px; 
            border-radius: 10px; 
            cursor: pointer; 
        }
        .tab-btn.active { background: var(--card); color: var(--text); box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .tab-btn.reefer-active { background: var(--reefer-color); color: #fff; }

        .form-group { margin-bottom: 16px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; font-size: 13px; color: var(--text); }
        
        .input-wrapper { display: flex; gap: 8px; }
        input, select { 
            width: 100%; 
            padding: 12px 14px; 
            border: 1px solid var(--border); 
            border-radius: 12px; 
            background: var(--card); 
            color: var(--text); 
            font-size: 14px; 
            outline: none;
        }
        input:focus, select:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15); }
        input[type="datetime-local"] { direction: ltr; text-align: right; }

        .btn-small { 
            padding: 0 16px; 
            border: 1px solid var(--border); 
            background: var(--accent); 
            color: var(--text); 
            border-radius: 12px; 
            cursor: pointer; 
            font-size: 13px; 
            font-weight: 600;
            white-space: nowrap;
        }

        .grid-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
        
        .btn-reset { 
            width: 100%; 
            padding: 12px; 
            background: var(--accent); 
            color: var(--text); 
            border: 1px solid var(--border); 
            border-radius: 12px; 
            font-weight: 600; 
            font-size: 14px; 
            cursor: pointer; 
            margin-top: 8px;
        }

        .reefer-field { display: none; background: rgba(2, 132, 199, 0.05); padding: 14px; border-radius: 14px; border: 1px dashed var(--reefer-color); margin-bottom: 16px; }

        .result-box { 
            margin-top: 24px; 
            padding: 24px; 
            border-radius: 18px; 
            border: 2px solid var(--border); 
            display: none; 
            animation: fadeIn 0.3s ease-out;
        }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }

        .result-box.safe { background: var(--safe-bg); border-color: var(--safe-border); color: var(--safe-text); }
        .result-box.danger { background: var(--danger-bg); border-color: var(--danger-border); color: var(--danger-text); }

        .progress-bar-bg { background: rgba(0,0,0,0.08); height: 12px; border-radius: 8px; overflow: hidden; margin: 14px 0; }
        .progress-bar-fill { height: 100%; width: 0%; transition: width 0.5s ease-in-out, background-color 0.5s ease; }

        .actions-grid { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 10px; margin-top: 20px; }
        .btn-action { 
            padding: 12px; 
            border: 1px solid var(--border); 
            background: var(--card); 
            color: var(--text); 
            border-radius: 10px; 
            cursor: pointer; 
            font-size: 13px; 
            font-weight: 600; 
            text-align: center; 
            text-decoration: none; 
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }

        .stats-grid { display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 10px; margin-top: 16px; margin-bottom: 12px; }
        .stat-card { background: var(--accent); padding: 12px; border-radius: 12px; text-align: center; font-size: 12px; }
        .stat-card span { display: block; font-size: 18px; font-weight: 800; margin-top: 2px; }

        .history-section { margin-top: 32px; border-top: 1px solid var(--border); padding-top: 20px; }
        .history-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px; }
        .history-list { list-style: none; max-height: 220px; overflow-y: auto; font-size: 13px; }
        .history-item { padding: 12px; border-bottom: 1px solid var(--border); display: flex; justify-content: space-between; align-items: center; }

        .toast {
            position: fixed;
            bottom: 20px;
            left: 50%;
            transform: translateX(-50%) translateY(100px);
            background: #0f172a;
            color: #fff;
            padding: 12px 24px;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 600;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            transition: transform 0.3s ease-out;
            z-index: 1000;
        }
        .toast.show { transform: translateX(-50%) translateY(0); }

        /* قالب طباعة السند (PDF الاحترافي) مخفي افتراضياً ويظهر فقط عند الطباعة */
        #printReceipt { display: none; }

        @media print {
            body { background: #fff !important; color: #000 !important; padding: 0; margin: 0; direction: rtl; }
            .container, .toast { display: none !important; }
            #printReceipt { 
                display: block !important; 
                padding: 15px; 
                width: 100%; 
                font-family: Arial, sans-serif;
            }
            .receipt-header { text-align: center; border-bottom: 2px solid #000; padding-bottom: 10px; margin-bottom: 20px; }
            .receipt-header h1 { font-size: 20px; margin-bottom: 5px; }
            .receipt-header p { font-size: 12px; color: #333; }
            .receipt-table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
            .receipt-table th, .receipt-table td { border: 1px solid #000; padding: 8px 10px; text-align: right; font-size: 13px; }
            .receipt-table th { background: #f0f0f0 !important; -webkit-print-color-adjust: exact; print-color-adjust: exact; }
            .signatures { display: flex; justify-content: space-between; margin-top: 60px; padding: 0 10px; }
            .signature-box { text-align: center; font-weight: bold; font-size: 13px; }
        }

        @media (max-width: 480px) {
            .grid-2, .stats-grid { grid-template-columns: 1fr; }
            .container { padding: 20px; }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h2>⚡ نظام حساب اللكعة</h2>
        <button id="themeToggleBtn" class="theme-btn" onclick="toggleTheme()">🌙 مظهر مظلم</button>
    </div>

    <div class="tabs">
        <button id="tabNormal" class="tab-btn active" onclick="switchTab('normal')">🚚 لكعة شحن عامة</button>
        <button id="tabReefer" class="tab-btn" onclick="switchTab('reefer')">❄️ لكعة براد</button>
    </div>

    <div class="grid-2">
        <div class="form-group">
            <label>👤 اسم السائق / الشاحنة:</label>
            <input type="text" id="driverName" placeholder="مثال: أحمد - براد 102" oninput="calculateLive()">
        </div>
        <div class="form-group">
            <label>📄 رقم الوصل (اختياري):</label>
            <input type="text" id="receiptNo" placeholder="مثال: #9402" oninput="calculateLive()">
        </div>
    </div>

    <div class="grid-2">
        <div class="form-group">
            <label>⏱️ تاريخ ووقت قطع الوصل:</label>
            <input type="datetime-local" id="startDate" onchange="calculateLive()">
        </div>
        <div class="form-group">
            <label>📦 تاريخ ووقت تفريغ الحمل:</label>
            <div class="input-wrapper">
                <input type="datetime-local" id="endDate" onchange="calculateLive()">
                <button class="btn-small" onclick="setCurrentTime()">الآن</button>
            </div>
        </div>
    </div>

    <div id="reeferBox" class="reefer-field">
        <div class="form-group">
            <label>🌡️ نوع البضاعة المبردة:</label>
            <select id="cargoType" onchange="calculateLive()">
                <option value="مجمدات">مجمدات (-18°C)</option>
                <option value="خضار وفواكه">خضار وفواكه طازجة</option>
                <option value="أدوية/مواد حساسة">أدوية / مواد حساسة</option>
            </select>
        </div>
        <div class="grid-2">
            <div class="form-group" style="margin-bottom:0;">
                <label>❄️ لكعة التبريد (سعر اليوم):</label>
                <input type="number" id="coolingRatePerDay" placeholder="0.00" oninput="calculateLive()">
            </div>
            <div class="form-group" style="margin-bottom:0;">
                <label>🚚 لكعة الشحن (سعر اليوم):</label>
                <input type="number" id="shippingRatePerDay" placeholder="0.00" oninput="calculateLive()">
            </div>
        </div>
    </div>

    <div class="grid-2" id="normalRateBox">
        <div class="form-group">
            <label>💰 لكعة الشحن/اليوم (اختياري):</label>
            <input type="number" id="ratePerDay" placeholder="0.00" oninput="calculateLive()">
        </div>
        <div class="form-group">
            <label>⏳ المهلة المسموحة (ساعة):</label>
            <input type="number" id="graceHours" value="48" oninput="calculateLive()">
        </div>
    </div>

    <div class="form-group">
        <label>📅 استثناء العطل الرسمية من الحساب:</label>
        <select id="holidayMode" onchange="calculateLive()">
            <option value="none">بدون استثناء عطلات</option>
            <option value="friday" selected>استثناء يوم الجمعة فقط</option>
            <option value="weekend">استثناء الجمعة والسبت</option>
        </select>
    </div>

    <button class="btn-reset" onclick="resetForm()">🔄 إعادة ضبط الحقول</button>

    <div id="resultBox" class="result-box">
        <div id="resTitle" style="font-weight: 800; font-size: 18px;"></div>
        
        <div class="progress-bar-bg">
            <div id="progressFill" class="progress-bar-fill"></div>
        </div>

        <div id="resDetails" style="font-size: 14px; margin-top: 8px;"></div>
        <div id="resCost" style="font-weight: 800; margin-top: 8px; font-size: 16px;"></div>

        <div class="actions-grid">
            <button class="btn-action" onclick="copyReport()">📋 نسخ النص</button>
            <a id="whatsappBtn" target="_blank" class="btn-action" style="background:#25D366; color:white; border:none;">💬 واتساب</a>
            <button class="btn-action" onclick="window.print()" style="background:var(--primary); color:white; border:none;">🖨️ طباعة سند PDF</button>
        </div>
    </div>

    <div class="history-section">
        <div class="history-header">
            <strong>📊 سجل الحسابات والإحصائيات:</strong>
            <input type="text" style="width: 140px; padding: 6px 12px; font-size: 12px;" placeholder="بحث..." oninput="filterHistory(this.value)">
        </div>

        <div class="stats-grid">
            <div class="stat-card">إجمالي الحسابات<span id="statTotal">0</span></div>
            <div class="stat-card" style="color:var(--safe-text);">ضمن المهلة<span id="statSafe">0</span></div>
            <div class="stat-card" style="color:var(--danger-text);">لكعة / تأخير<span id="statDanger">0</span></div>
        </div>

        <ul id="historyList" class="history-list"></ul>
        
        <div style="display: flex; gap: 8px; margin-top: 14px;">
            <button class="btn-action" style="flex:2;" onclick="exportToCSV()">📥 تصدير السجل (CSV)</button>
            <button class="btn-action" style="flex:1; color:#ef4444;" onclick="clearHistory()">🗑️ مسح السجل</button>
        </div>
    </div>
</div>

<!-- قالب طباعة السند الرسمي بصيغة PDF -->
<div id="printReceipt">
    <div class="receipt-header">
        <h1>سند لكعة وتفريغ حمولة رسمية</h1>
        <p>تاريخ إصدار السند: <span id="pIssueDate"></span></p>
    </div>

    <table class="receipt-table">
        <tr>
            <th>اسم السائق / الشاحنة:</th>
            <td id="pDriver"></td>
            <th>رقم الوصل:</th>
            <td id="pReceipt"></td>
        </tr>
        <tr>
            <th>نوع العملية:</th>
            <td id="pType"></td>
            <th>نوع البضاعة:</th>
            <td id="pCargo">-</td>
        </tr>
        <tr>
            <th>تاريخ قطع الوصل:</th>
            <td id="pStartDate"></td>
            <th>تاريخ التفريغ الفعلي:</th>
            <td id="pEndDate"></td>
        </tr>
        <tr>
            <th>المهلة المسموحة:</th>
            <td id="pGrace"></td>
            <th>فترة التأخير:</th>
            <td id="pDelayTime"></td>
        </tr>
        <tr>
            <th>عدد أيام اللكعة المحسوبة:</th>
            <td id="pDelayDays" colspan="3" style="font-weight: bold;"></td>
        </tr>
    </table>

    <table class="receipt-table">
        <thead>
            <tr>
                <th>بيان المستحقات والرسوم</th>
                <th>سعر اليوم</th>
                <th>الأيام المحسوبة</th>
                <th>الإجمالي</th>
            </tr>
        </thead>
        <tbody id="pCostTable">
        </tbody>
    </table>

    <div style="margin-top: 15px; font-size: 11px; color: #444; border-top: 1px dashed #999; padding-top: 8px;">
        * ملاحظة: تم احتساب الأيام وفق الشروط المعتمدة (جبر كسور الأيام إلى يوم كامل، واستثناء العطل إن وجدت).
    </div>

    <div class="signatures">
        <div class="signature-box">توقيع السائق<br><br>...........................</div>
        <div class="signature-box">توقيع المستلم<br><br>...........................</div>
        <div class="signature-box">ختم وتوقيع الإدارة<br><br>...........................</div>
    </div>
</div>

<div id="toast" class="toast">تمت العملية بنجاح!</div>

<script>
    let currentMode = 'normal';
    let historyData = JSON.parse(localStorage.getItem('delayHistory')) || [];
    let currentReport = "";

    window.onload = function() {
        const savedTheme = localStorage.getItem('appTheme');
        if (savedTheme === 'dark') {
            document.body.classList.add('dark-theme');
            document.getElementById('themeToggleBtn').innerText = '☀️ مظهر نهار';
        }
        renderHistory();
    };

    function switchTab(mode) {
        currentMode = mode;
        const btnNormal = document.getElementById('tabNormal');
        const btnReefer = document.getElementById('tabReefer');
        const reeferBox = document.getElementById('reeferBox');
        const normalRateBox = document.getElementById('normalRateBox');
        const graceInput = document.getElementById('graceHours');

        if (mode === 'reefer') {
            btnNormal.className = 'tab-btn';
            btnReefer.className = 'tab-btn reefer-active';
            reeferBox.style.display = 'block';
            normalRateBox.style.gridTemplateColumns = '1fr';
            document.getElementById('ratePerDay').parentElement.style.display = 'none';
            graceInput.value = '24';
        } else {
            btnNormal.className = 'tab-btn active';
            btnReefer.className = 'tab-btn';
            reeferBox.style.display = 'none';
            normalRateBox.style.gridTemplateColumns = '1fr 1fr';
            document.getElementById('ratePerDay').parentElement.style.display = 'block';
            graceInput.value = '48';
        }
        calculateLive();
    }

    function showToast(msg) {
        const toast = document.getElementById('toast');
        toast.innerText = msg;
        toast.classList.add('show');
        setTimeout(() => toast.classList.remove('show'), 2500);
    }

    function setCurrentTime() {
        const now = new Date();
        now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
        document.getElementById('endDate').value = now.toISOString().slice(0, 16);
        calculateLive();
    }

    function toggleTheme() {
        const isDark = document.body.classList.toggle('dark-theme');
        document.getElementById('themeToggleBtn').innerText = isDark ? '☀️ مظهر نهار' : '🌙 مظهر مظلم';
        localStorage.setItem('appTheme', isDark ? 'dark' : 'light');
    }

    function calculateLive() {
        const driver = document.getElementById('driverName').value.trim() || "سائق غير محدد";
        const receipt = document.getElementById('receiptNo').value.trim() || "بدون رقم";
        const startVal = document.getElementById('startDate').value;
        const endVal = document.getElementById('endDate').value;
        const grace = parseFloat(document.getElementById('graceHours').value) || 24;
        const holidayMode = document.getElementById('holidayMode').value;

        const resultBox = document.getElementById('resultBox');
        if (!startVal || !endVal) {
            resultBox.style.display = "none";
            return;
        }

        const start = new Date(startVal);
        const end = new Date(endVal);
        if (end < start) {
            resultBox.style.display = "none";
            return;
        }

        let totalHours = (end - start) / (1000 * 60 * 60);

        if (holidayMode !== "none") {
            let temp = new Date(start);
            let holidayHours = 0;
            while (temp < end) {
                const day = temp.getDay();
                if (holidayMode === "friday" && day === 5) holidayHours += 24;
                else if (holidayMode === "weekend" && (day === 5 || day === 6)) holidayHours += 24;
                temp.setDate(temp.getDate() + 1);
            }
            totalHours = Math.max(0, totalHours - holidayHours);
        }

        const delayHours = totalHours - grace;
        const resTitle = document.getElementById('resTitle');
        const resDetails = document.getElementById('resDetails');
        const resCost = document.getElementById('resCost');
        const progressFill = document.getElementById('progressFill');

        resultBox.style.display = "block";

        const percent = Math.min(100, (totalHours / grace) * 100);
        progressFill.style.width = percent + "%";

        const isSafe = delayHours <= 0;
        const modeLabel = currentMode === 'reefer' ? '❄️ لكعة براد' : '🚚 لكعة شحن عامة';

        // تعبئة حقول السند المخصص للطباعة
        document.getElementById('pIssueDate').innerText = new Date().toLocaleString('ar-EG');
        document.getElementById('pDriver').innerText = driver;
        document.getElementById('pReceipt').innerText = receipt;
        document.getElementById('pType').innerText = modeLabel;
        document.getElementById('pStartDate').innerText = startVal.replace('T', ' ');
        document.getElementById('pEndDate').innerText = endVal.replace('T', ' ');
        document.getElementById('pGrace').innerText = grace + " ساعة";

        const costTableBody = document.getElementById('pCostTable');

        if (isSafe) {
            resultBox.className = "result-box safe";
            progressFill.style.background = percent > 80 ? "#f59e0b" : "#10b981";
            resTitle.innerText = `تفريغ الحمل ضمن المهلة (${modeLabel}) ✅`;
            resDetails.innerText = `السائق: ${driver} | وصل: ${receipt} | الوقت المنقضي: ${totalHours.toFixed(1)} ساعة من أصل ${grace} ساعة.`;
            resCost.innerText = "";
            currentReport = `تقرير تفريغ الحمل (${modeLabel}):\n- السائق: ${driver}\n- الوصل: ${receipt}\n- الحالة: ضمن المهلة (${totalHours.toFixed(1)}س من أصل ${grace}س).`;

            document.getElementById('pDelayTime').innerText = "لا يوجد تأخير";
            document.getElementById('pDelayDays').innerText = "0 يوم (ضمن المهلة)";
            document.getElementById('pCargo').innerText = currentMode === 'reefer' ? document.getElementById('cargoType').value : "بضاعة عامة";
            costTableBody.innerHTML = `<tr><td colspan="4" style="text-align:center;">تم تفريغ الحمل ضمن المهلة المحددة (لا توجد مستحقات لكعة)</td></tr>`;
        } else {
            resultBox.className = "result-box danger";
            progressFill.style.background = "#ef4444";
            
            const delayDaysCalculated = Math.ceil(delayHours / 24);
            const actualDays = Math.floor(delayHours / 24);
            const actualHours = Math.floor(delayHours % 24);
            let timeStr = `${actualDays > 0 ? actualDays + ' يوم و ' : ''}${actualHours} ساعة`;

            document.getElementById('pDelayTime').innerText = `${delayHours.toFixed(1)} ساعة (${timeStr})`;
            document.getElementById('pDelayDays').innerText = `${delayDaysCalculated} يوم لكعة (محسوبة)`;

            let totalCost = 0;
            let costBreakdown = "";
            let tableHTML = "";

            if (currentMode === 'reefer') {
                const coolingRate = parseFloat(document.getElementById('coolingRatePerDay').value) || 0;
                const shippingRate = parseFloat(document.getElementById('shippingRatePerDay').value) || 0;
                const cargo = document.getElementById('cargoType').value;

                document.getElementById('pCargo').innerText = cargo;

                const coolingCost = delayDaysCalculated * coolingRate;
                const shippingCost = delayDaysCalculated * shippingRate;
                totalCost = coolingCost + shippingCost;

                resTitle.innerText = `لكعة براد: ${delayDaysCalculated} يوم (${delayHours.toFixed(1)} ساعة تأخير) ⚠️`;
                resDetails.innerText = `السائق: ${driver} | وصل: ${receipt} | الوقت الفعلي: ${timeStr} | المحسوب: ${delayDaysCalculated} يوم لكعة | نوع البضاعة: ${cargo}`;

                if (coolingRate > 0) tableHTML += `<tr><td>لكعة تبريد براد</td><td>${coolingRate}</td><td>${delayDaysCalculated}</td><td>${coolingCost.toFixed(2)}</td></tr>`;
                if (shippingRate > 0) tableHTML += `<tr><td>لكعة شحن وتأخير شاحنة</td><td>${shippingRate}</td><td>${delayDaysCalculated}</td><td>${shippingCost.toFixed(2)}</td></tr>`;

                if (totalCost > 0) {
                    costBreakdown = `إجمالي المستحق: ${totalCost.toFixed(2)}`;
                    let parts = [];
                    if (coolingCost > 0) parts.push(`تبريد: ${coolingCost.toFixed(2)}`);
                    if (shippingCost > 0) parts.push(`شحن: ${shippingCost.toFixed(2)}`);
                    if (parts.length > 0) costBreakdown += ` (${parts.join(' + ')})`;
                }
            } else {
                const rate = parseFloat(document.getElementById('ratePerDay').value) || 0;
                totalCost = delayDaysCalculated * rate;

                document.getElementById('pCargo').innerText = "بضاعة عامة";

                resTitle.innerText = `تجاوز مهلة الشحن: ${delayDaysCalculated} يوم لكعة ⚠️`;
                resDetails.innerText = `السائق: ${driver} | وصل: ${receipt} | الوقت الفعلي: ${timeStr} | المحسوب: ${delayDaysCalculated} يوم لكعة`;
                
                if (rate > 0) tableHTML += `<tr><td>لكعة شحن وتأخير شاحنة</td><td>${rate}</td><td>${delayDaysCalculated}</td><td>${totalCost.toFixed(2)}</td></tr>`;
                if (totalCost > 0) costBreakdown = `المبلغ المستحق: ${totalCost.toFixed(2)}`;
            }

            tableHTML += `<tr style="font-weight:bold; background:#f9f9f9;"><td colspan="3" style="text-align:left;">إجمالي المبالغ المستحقة:</td><td>${totalCost.toFixed(2)}</td></tr>`;
            costTableBody.innerHTML = tableHTML;

            resCost.innerText = costBreakdown;

            currentReport = `تقرير لكعة (${modeLabel}):\n- السائق: ${driver}\n- رقم الوصل: ${receipt}\n- قطع الوصل: ${startVal.replace('T', ' ')}\n- وقت التفرغ: ${endVal.replace('T', ' ')}\n- التأخير الفعلي: ${delayHours.toFixed(1)} ساعة (${timeStr})\n- الأيام المحسوبة: ${delayDaysCalculated} يوم`;
            if (costBreakdown) currentReport += `\n- ${costBreakdown}`;
        }

        document.getElementById('whatsappBtn').href = `https://wa.me/?text=${encodeURIComponent(currentReport)}`;
        saveToHistoryThrottled({ driver, receipt, type: modeLabel, isSafe, status: isSafe ? "ضمن المهلة" : `${Math.ceil(delayHours / 24)} يوم لكعة`, date: new Date().toLocaleDateString('ar-EG') });
    }

    let saveTimeout;
    function saveToHistoryThrottled(record) {
        clearTimeout(saveTimeout);
        saveTimeout = setTimeout(() => {
            if (historyData.length > 0 && historyData[0].driver === record.driver && historyData[0].status === record.status) return;
            historyData.unshift(record);
            localStorage.setItem('delayHistory', JSON.stringify(historyData));
            renderHistory();
        }, 1200);
    }

    function resetForm() {
        document.getElementById('driverName').value = "";
        document.getElementById('receiptNo').value = "";
        document.getElementById('startDate').value = "";
        document.getElementById('endDate').value = "";
        document.getElementById('ratePerDay').value = "";
        document.getElementById('coolingRatePerDay').value = "";
        document.getElementById('shippingRatePerDay').value = "";
        document.getElementById('resultBox').style.display = "none";
        showToast("تم تفريغ الحقول وإعادة الضبط!");
    }

    function copyReport() {
        navigator.clipboard.writeText(currentReport).then(() => showToast("تم نسخ التقرير إلى الحافظة! 📋"));
    }

    function renderHistory(filter = "") {
        const list = document.getElementById('historyList');
        list.innerHTML = "";
        const filtered = historyData.filter(item => item.driver.includes(filter) || item.receipt.includes(filter));
        
        document.getElementById('statTotal').innerText = historyData.length;
        document.getElementById('statSafe').innerText = historyData.filter(i => i.isSafe).length;
        document.getElementById('statDanger').innerText = historyData.filter(i => !i.isSafe).length;

        if (filtered.length === 0) {
            list.innerHTML = `<li class="history-item" style="color:var(--text-secondary);">لا توجد سجلات محفوظة.</li>`;
            return;
        }

        filtered.forEach(item => {
            const li = document.createElement('li');
            li.className = 'history-item';
            const badgeColor = item.isSafe ? 'color:var(--safe-text);' : 'color:var(--danger-text); font-weight:bold;';
            li.innerHTML = `<span><strong>${item.driver}</strong> [${item.type}] (${item.receipt}): <span style="${badgeColor}">${item.status}</span></span><span style="color:var(--text-secondary); font-size:11px;">${item.date}</span>`;
            list.appendChild(li);
        });
    }

    function filterHistory(val) { renderHistory(val); }

    function clearHistory() {
        if (confirm("هل أنت تأكد من مسح جميع السجلات المحفوظة؟")) {
            historyData = [];
            localStorage.removeItem('delayHistory');
            renderHistory();
            showToast("تم مسح السجل بنجاح!");
        }
    }

    function exportToCSV() {
        if (historyData.length === 0) return showToast("لا توجد بيانات لتصديرها.");
        let csv = "\uFEFFالاسم/الشاحنة,النوع,رقم الوصل,الحالة,التاريخ\n";
        historyData.forEach(row => { csv += `"${row.driver}","${row.type}","${row.receipt}","${row.status}","${row.date}"\n`; });
        const blob = new Blob([csv], { type: 'text/csv;charset=utf-8;' });
        const link = document.createElement("a");
        link.href = URL.createObjectURL(blob);
        link.download = "سجل_تفريغ_الحمل.csv";
        link.click();
        showToast("تم تصدير ملف CSV بنجاح! 📥");
    }
</script>

</body>
</html>
