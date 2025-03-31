# monitoring-workshop

- Todolist
  - [ ] set alert to send notification to discord.
  - [x] pull metric from app.
  - [ ] use push gateway to get metric from cronjob.
  - [ ] intergration with thanos.
  - [ ] use terraform to manage dashboards.
  - [ ] opentelemetry

# Dashboard 規劃

### **1. 系統資源監控 Dashboard**
- **目標**：展示 Kubernetes 節點的系統資源使用情況。
- **數據來源**：Node Exporter。
- **指標範例**：
  - **CPU 使用率**：
    ```promql
    100 * (1 - avg(rate(node_cpu_seconds_total{mode="idle"}[5m])) by (instance))
    ```
  - **內存使用率**：
    ```promql
    100 * (1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes))
    ```
  - **磁盤使用率**：
    ```promql
    100 * (1 - (node_filesystem_avail_bytes / node_filesystem_size_bytes))
    ```

---

### **2. 應用性能監控 Dashboard**
- **目標**：展示應用的性能指標，例如請求數量和響應時間。
- **數據來源**：自定義的 Node.js 應用（或其他應用）。
- **指標範例**：
  - **HTTP 請求總數**：
    ```promql
    sum(rate(http_requests_total[5m])) by (method, route, status)
    ```
  - **95% 響應時間**：
    ```promql
    histogram_quantile(0.95, sum(rate(http_response_time_seconds_bucket[5m])) by (le, method, route))
    ```

---

### **3. 告警狀態 Dashboard**
- **目標**：展示當前系統的告警狀態。
- **數據來源**：Prometheus Alertmanager。
- **指標範例**：
  - **當前活躍告警數量**：
    ```promql
    count(ALERTS{alertstate="firing"})
    ```
  - **按嚴重性分組的告警數量**：
    ```promql
    count(ALERTS{alertstate="firing"}) by (severity)
    ```
