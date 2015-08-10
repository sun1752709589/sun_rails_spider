var Birt = (function () {
    var _this;

    var rptDesignJsonData;

    var $birt;

    function Birt(designJsonData) {
        _this = this;
        rptDesignJsonData = designJsonData;
        $birt = $('.birt');
    }

    /**
     * 获取报表数据
     * @param rptDesignName
     */
    Birt.prototype.getRetDesign = function (rptDesignName) {
        $.birtLoading();
        $.ajax(
            {
                url: '/birt/api.json?_report={0}'.format(rptDesignName || $birt.data('rptdesign')),
                type: 'GET',
                success: function (data) {
                    $.birtLoading('hide');
                    rptDesignJsonData = data.rpt_design;
                    _this.showDisplayName();
                    console.log(data.rpt_design.tables);

                    var tables = data.rpt_design.tables;
                    for (var i = 0; i < tables.length; i++) {
                        var table = tables[i];
                        _this.showTable(table);
                    }

                    var lineCharts = data.rpt_design.line_charts;
                    for (var i = 0; i < lineCharts.length; i++) {
                        _this.showLineChart(lineCharts[i]);
                    }
                },
                error: function (data) {
                    $.birtLoading('hide');
                }
            }
        );
    };

    Birt.prototype.showDisplayName = function () {
        $birt.append('<h2>{0}</h2>'.format(rptDesignJsonData.display_name));
    };


    /**
     * 显示行
     * @param rowData
     * @param cellName
     * @returns {string}
     */
    Birt.prototype.showTableRow = function (rowData, cellName) {

        var row_html = '<tr>';
        for (var i = 0; i < rowData.length; i++) {
            if (cellName == 'th') {
                row_html += "<th>{0}</th>".format(rowData[i]);
            } else {
                row_html += "<td>{0}</td>".format(rowData[i]);
            }
        }
        row_html += '</tr>';
        return row_html;
    };

    /**
     * 显示表格
     * @param table
     * @returns {string}
     */
    Birt.prototype.showTable = function (table) {
        var table_html = '<table id="report_{0}" class="birt-table"> '.format(table.id);

        for (var i = 0; i < table.header.length; i++) {
            table_html += _this.showTableRow(table.header[i], 'th');
        }


        for (var i = 0; i < table.detail.length; i++) {
            table_html += _this.showTableRow(table.detail[i], 'td');
        }

        table_html += "</table>";

        $(".birt").append(table_html);
        console.log(table);
        return table_html;
    };


    Birt.prototype.showLineChart = function (lineChart) {
        $(".birt").append("<div id='report_{0}'></div>".format(lineChart.id));
        new Highcharts.Chart({
            chart: {
                renderTo: "report_{0}".format(lineChart.id),
                plotBackgroundColor: null,
                plotBorderWidth: null,
                defaultSeriesType: 'spline'
            },
            title: {
                text: lineChart.title
            },
            xAxis: {
                categories: lineChart.x_data,
                labels: {
                    rotation: -45, //字体倾斜
                    align: 'right',
                    style: {font: 'normal 13px 宋体'}
                }
            },
            yAxis: {
                title: {
                    text: "销量/元"
                }
            },

            series: lineChart.series
        });
    };
    return Birt;
})();
