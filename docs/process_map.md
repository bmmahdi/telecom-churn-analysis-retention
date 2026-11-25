# Process Maps — Customer Churn Analysis and Retention Strategy

Two views of the retention process: the **AS-IS** state (how churn is handled today) and the
**TO-BE** state (how it will work once the analysis and dashboard are in place).

---

## AS-IS — Reactive retention

```mermaid
flowchart LR
    subgraph Customer["👤 Customer"]
        C1[Uses service]
        C2[Considers leaving]
        C3[Calls to cancel]
    end

    subgraph CRM["🗂️ CRM / Billing"]
        B1[Monthly invoice]
        B2[Churn recorded]
    end

    subgraph Retention["🎧 Retention Team"]
        R1[Receives cancellation call]
        R2[Offers generic discount]
        R3[Logs outcome]
    end

    subgraph Marketing["📣 Marketing"]
        M1[Quarterly campaign]
        M2[Mass email blast]
    end

    subgraph Leadership["📊 Leadership"]
        L1[Monthly churn report]
        L2[Reacts after the fact]
    end

    C1 --> B1 --> C2 --> C3 --> R1 --> R2 --> R3 --> B2 --> L1 --> L2
    M1 --> M2 --> C1
```

**Pain points**
- Retention is triggered only when the customer calls to cancel — too late.
- Offers are generic (flat discount) and not segment-specific.
- Marketing campaigns are mass-market, not targeted at high-risk segments.
- Leadership sees churn only after it has happened.

---

## TO-BE — Proactive, data-driven retention

```mermaid
flowchart LR
    subgraph Data["🗄️ Data Team"]
        D1[Daily CRM extract]
        D2[Clean & transform]
        D3[Score churn risk]
        D4[Publish dashboard]
    end

    subgraph Retention["🎧 Retention Team"]
        R1[Review high-risk segments]
        R2[Select targeted offer]
        R3[Outreach: call / email / SMS]
        R4[Log outcome]
    end

    subgraph Marketing["📣 Marketing"]
        M1[Design segment campaigns]
        M2[Launch contract-migration offer]
        M3[Launch add-on bundle]
    end

    subgraph Customer["👤 Customer"]
        C1[Receives targeted offer]
        C2[Accepts / declines]
        C3[Stays or churns]
    end

    subgraph Leadership["📊 Leadership"]
        L1[Weekly KPI review]
        L2[Adjust budget allocation]
    end

    D1 --> D2 --> D3 --> D4
    D4 --> R1 --> R2 --> R3 --> C1 --> C2 --> C3
    C3 --> R4 --> D1
    D4 --> M1 --> M2 --> C1
    D4 --> M3 --> C1
    D4 --> L1 --> L2 --> M1
```

**Improvements**
- Churn risk is scored **before** the customer calls to cancel.
- Offers are **segment-specific** (contract migration, add-on bundle, payment migration).
- Marketing campaigns are **targeted** at the top revenue-at-risk segments.
- Leadership reviews KPIs **weekly** and reallocates budget based on the dashboard.

---

## Gap analysis

| # | Gap (AS-IS) | Impact | TO-BE action | Owner |
|---|---|---|---|---|
| 1 | Retention triggered only on cancellation call | High — lost revenue | Score churn risk daily and trigger proactive outreach | Data Team + Retention |
| 2 | Generic discount offers | Medium — margin erosion | Segment-specific offers (contract, add-on, payment) | Retention Manager |
| 3 | Mass-market marketing | Medium — low ROI | Targeted campaigns on top revenue-at-risk segments | Marketing Director |
| 4 | Monthly, lagging churn reporting | High — slow reaction | Weekly dashboard review with KPI cards | Leadership |
| 5 | No visibility on add-on impact | Medium — missed upsell | Track churn by Tech Support / Online Security adoption | Product Managers |
| 6 | No feedback loop from outcomes | Medium — no learning | Log every outreach outcome and feed back into the model | Data Team |
