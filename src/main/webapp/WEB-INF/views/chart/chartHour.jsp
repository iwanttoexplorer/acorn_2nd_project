<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="CP" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시간별 사망자 수 및 부상자 수 차트</title>
<%-- bootstrap css --%>
<link rel="stylesheet" href="${CP}/resources/css/bootstrap/bootstrap.css"> 
<script src="${CP}/resources/js/common.js"></script>
<script src="${CP}/resources/js/jquery_3_7_1.js"></script>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        fetch('${CP}/chart/chartData3.do')
            .then(response => {
                if (!response.ok) {
                    throw new Error('네트워크 오류');
                }
                return response.json();
            })
            .then(data => {
                const dataTable = new google.visualization.DataTable();
                dataTable.addColumn('string', '시간대');
                dataTable.addColumn('number', '사망자 수');
                dataTable.addColumn('number', '부상자 수');
                dataTable.addColumn('number', '중상자 수');

                data.forEach(item => {
                    dataTable.addRow([item.HOUR_RANGE, item.TOTAL_DEATHS || 0, item.TOTAL_CASUALTIES || 0, item.TOTAL_SERIOUSLY || 0]);
                });

                const options = {
                    title: '시간별 사망자 수, 부상자 수 및 중상자 수',
                    hAxis: {
                        title: '시간대',
                        titleTextStyle: {color: '#333'}
                    },
                    vAxis: {
                        minValue: 0
                    },
                    chartArea: {width: '70%', height: '70%'},
                    colors: ['#FF0000', '#FFFF00', '#0000FF'], // 각 데이터 시리즈의 색상 설정
                    curveType: 'function', // 부드러운 곡선으로 표시
                    legend: { position: 'bottom' },
                    animation: {
                        startup: true,
                        duration: 1000,
                        easing: 'out'
                    }
                };

                const chart = new google.visualization.LineChart(document.getElementById('chartContainer'));
                chart.draw(dataTable, options);
            })
            .catch(error => console.error('차트 데이터 가져오기 오류:', error));
    }
</script>

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.showChartsButton').forEach((button, index) => {
            button.addEventListener('click', () => {
                switch (index) {
                    case 0:
                        window.location.href = '${CP}/chart/chartMonth.do';
                        break;
                    case 1:
                        window.location.href = '${CP}/chart/chartWeek.do';
                        break;
                    case 2:
                        window.location.href = '${CP}/chart/chartHour.do';
                        break;
                    case 3:
                        window.location.href = '${CP}/chart/chartNight.do'; // 예시 URL
                        break;
                    case 4:
                        window.location.href = '${CP}/chart/chartMajor.do'; // 예시 URL
                        break;
                    case 5:
                        window.location.href = '${CP}/chart/chartMedium.do'; // 예시 URL
                        break;
                    case 6:
                        window.location.href = '${CP}/chart/chartGname.do'; // 예시 URL
                        break;
                    case 7:
                        window.location.href = '${CP}/chart/chartSummary.do'; // 예시 URL
                        break;
                }
            });
        });
    });
</script>

<style>
    .center-content {
        text-align: center;
        margin: 20px 0;
    }
    .button-container {
        display: flex;
        justify-content: center;
        gap: 10px;
        flex-wrap: wrap;
        margin: 20px 0;
    }
    .showChartsButton {
        padding: 10px 20px;
        font-size: 14px;
    }
</style>
</head>
<body>
<%@ include file="/WEB-INF/views/template/header.jsp" %>

    <div class="center-content">
        <h1>시간별 총 사망자 수 및 부상자 수</h1>
    </div>
    
    <!-- 버튼 컨테이너 -->
    <div class="button-container">
        <button class="showChartsButton">월별 교통사고</button>
        <button class="showChartsButton">요일별 교통사고</button>
        <button class="showChartsButton">시간대별 교통사고</button>
        <button class="showChartsButton">주야별 교통사고</button>
        <button class="showChartsButton">사고유형별 교통사고</button>
        <button class="showChartsButton">사고종류별 교통사고</button>
        <button class="showChartsButton">시군구별 교통사고</button>
        <button class="showChartsButton">이건 걍만든버튼</button>
    </div>
    
    <!-- 차트 컨테이너 -->
    <div id="chartContainer" style="height: 500px; margin: 0 auto;"></div>
</body>
<%@ include file="/WEB-INF/views/template/footer.jsp" %> 
</html>
