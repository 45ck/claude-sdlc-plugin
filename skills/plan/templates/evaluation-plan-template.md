# Evaluation Plan

**Project**: {{PROJECT_NAME}}
**Plan Date**: {{PLAN_DATE}}
**Evaluation Lead**: {{LEAD_NAME}}

---

## Evaluation Objectives

### Primary Objectives
{{PRIMARY_OBJECTIVES}}

### Success Metrics
{{SUCCESS_METRICS}}

---

## Persona-Driven Participant Selection

### Selection Strategy

We will evaluate with representative users matching our defined personas to ensure coverage of diverse user populations and design requirements.

{{PERSONA_PARTICIPANT_TABLE}}

| Persona | Count | Selection Criteria | Recruitment Status |
|---------|-------|-------------------|-------------------|
{{PERSONA_ROWS}}

### Recruitment Plan

**Timeline**: {{RECRUITMENT_TIMELINE}}

**Recruitment Channels**:
{{RECRUITMENT_CHANNELS}}

**Screening Questions**:
{{SCREENING_QUESTIONS}}

### Practical Constraints

**Budget**: {{BUDGET}}
- Participant incentives: {{INCENTIVE_AMOUNT}} per session
- Total participant costs: {{TOTAL_PARTICIPANT_COST}}

**Schedule**: {{SCHEDULE_CONSTRAINT}}
- Sessions per week: {{SESSIONS_PER_WEEK}}
- Total evaluation period: {{TOTAL_DURATION}}

**Team Availability**:
{{TEAM_AVAILABILITY}}

---

## Evaluation Methods

### Method Selection

{{METHOD_SELECTION_RATIONALE}}

### Planned Methods

#### 1. Cognitive Walkthrough
**When**: {{CW_TIMING}}
**Who**: {{CW_PARTICIPANTS}}
**Focus**: {{CW_FOCUS}}

**Pre-planned Scenarios**:
{{CW_SCENARIOS}}

#### 2. Usability Testing
**When**: {{UT_TIMING}}
**Who**: {{UT_PARTICIPANTS}} (matching personas)
**Tasks**: {{UT_TASKS}}

**Success Criteria**:
- Task completion rate: ≥ {{COMPLETION_TARGET}}%
- Time on task: ≤ {{TIME_TARGET}} seconds
- Error rate: ≤ {{ERROR_TARGET}}%
- Satisfaction score: ≥ {{SATISFACTION_TARGET}}/5

#### 3. Heuristic Evaluation
**When**: {{HE_TIMING}}
**Who**: {{HE_EVALUATORS}} (UX experts)
**Heuristics**: {{HEURISTICS_SET}} (Nielsen's 10, WCAG 2.1, etc.)

---

## Persona-Scoped Scenarios

For each evaluation session, we will walk through pre-planned scenarios mapped to specific personas.

{{SCENARIO_TABLE}}

### {{SCENARIO_1_TITLE}}
**Persona**: {{SCENARIO_1_PERSONA}}
**Journey**: {{SCENARIO_1_JOURNEY}}

**Scenario Description**:
{{SCENARIO_1_DESCRIPTION}}

**Success Criteria**:
{{SCENARIO_1_SUCCESS_CRITERIA}}

**Walkthrough Script**:
1. {{STEP_1}}
2. {{STEP_2}}
3. {{STEP_3}}

**Expected Issues to Note**:
- {{EXPECTED_ISSUE_1}}
- {{EXPECTED_ISSUE_2}}

---

## Ethics & Informed Consent

### Informed Consent Checklist

- [ ] Participant information sheet prepared
- [ ] Consent form drafted and reviewed
- [ ] Right to withdraw explained
- [ ] Data handling procedures documented
- [ ] Anonymization strategy defined
- [ ] Ethics approval obtained (if required by institution)

### Participant Information

**What participants will be told**:
{{PARTICIPANT_INFO}}

**Data Usage**:
{{DATA_USAGE_POLICY}}

**Privacy Protections**:
{{PRIVACY_MEASURES}}

### Consent Form Elements

- [ ] Study purpose explained in plain language
- [ ] Procedures described (what they'll do, how long)
- [ ] Voluntary participation emphasized
- [ ] Right to withdraw at any time
- [ ] Confidentiality and anonymity guaranteed
- [ ] Data storage and retention explained
- [ ] Contact information for questions
- [ ] Signature and date fields

---

## Session Protocol

### Pre-Session (10 min)
1. Welcome participant
2. Review consent form and obtain signature
3. Explain think-aloud protocol
4. Answer any questions
5. Start recording (if consented)

### Session (30-45 min)
1. Warm-up task (familiarization)
2. Main tasks (persona-scoped scenarios)
3. Observing and note-taking
4. Probing questions as needed

### Post-Session (10 min)
1. Debrief questions
2. Satisfaction questionnaire
3. Thank participant
4. Provide incentive

### Session Materials Checklist
- [ ] Consent forms (2 copies - participant keeps one)
- [ ] Scenario scripts
- [ ] Task instructions
- [ ] Note-taking templates
- [ ] Recording equipment (if applicable)
- [ ] Incentive (cash/gift card)

---

## Data Collection

### Quantitative Metrics
{{QUANTITATIVE_METRICS}}

| Metric | Measurement Method | Target |
|--------|-------------------|--------|
| Task completion rate | Success/failure per task | ≥ {{TARGET}}% |
| Time on task | Stopwatch/screen recording | ≤ {{TARGET}}s |
| Errors | Count of errors per task | ≤ {{TARGET}} |
| Satisfaction | SUS or custom scale | ≥ {{TARGET}}/5 |

### Qualitative Data
{{QUALITATIVE_DATA}}

- Think-aloud observations
- Facial expressions / body language
- Frustration indicators
- Delight moments
- Suggestions and feedback

### Note-Taking Template

**Session ID**: _______
**Persona**: _______
**Date**: _______
**Observer**: _______

| Task | Success? | Time | Errors | Notes | Severity |
|------|----------|------|--------|-------|----------|
|      |          |      |        |       |          |

---

## Analysis Plan

### Issue Severity Classification

**Critical**: Prevents task completion, user cannot proceed
**Major**: Significant difficulty, task completion questionable
**Minor**: Slight inconvenience, task still completable
**Enhancement**: Suggestion for improvement, not blocking

### Reporting

**Findings Report Structure**:
1. Executive Summary
2. Methodology
3. Participant Demographics
4. Key Findings (by persona)
5. Issue List (prioritized by severity)
6. Recommendations
7. Next Steps

**Stakeholder Presentation**:
{{PRESENTATION_PLAN}}

---

## Iterative Testing Cycles

### Cycle 1: Low-Fidelity Prototype
**When**: {{CYCLE_1_TIMING}}
**Focus**: {{CYCLE_1_FOCUS}}
**Participants**: {{CYCLE_1_COUNT}} per persona
**Goal**: Validate core concept and workflow

### Cycle 2: Medium-Fidelity Prototype
**When**: {{CYCLE_2_TIMING}}
**Focus**: {{CYCLE_2_FOCUS}}
**Participants**: {{CYCLE_2_COUNT}} per persona
**Goal**: Refine interactions and information architecture

### Cycle 3: High-Fidelity Prototype
**When**: {{CYCLE_3_TIMING}}
**Focus**: {{CYCLE_3_FOCUS}}
**Participants**: {{CYCLE_3_COUNT}} per persona
**Goal**: Polish details and validate final design

---

## Heuristic Evaluation Checklist

### Nielsen's 10 Usability Heuristics

- [ ] **Visibility of system status**: System keeps users informed about what's going on
- [ ] **Match between system and real world**: System speaks users' language
- [ ] **User control and freedom**: Users can undo/redo actions
- [ ] **Consistency and standards**: Similar actions produce similar results
- [ ] **Error prevention**: Design prevents errors from occurring
- [ ] **Recognition rather than recall**: Minimize memory load
- [ ] **Flexibility and efficiency**: Shortcuts for expert users
- [ ] **Aesthetic and minimalist design**: No irrelevant information
- [ ] **Help users recognize, diagnose, recover from errors**: Clear error messages
- [ ] **Help and documentation**: Accessible when needed

### WCAG 2.1 AA Accessibility Checklist

- [ ] **Perceivable**: Text alternatives, captions, adaptable content, distinguishable
- [ ] **Operable**: Keyboard accessible, enough time, no seizures, navigable
- [ ] **Understandable**: Readable, predictable, input assistance
- [ ] **Robust**: Compatible with assistive technologies

---

## Risk Mitigation

### Recruitment Risks

**Risk**: Cannot recruit enough participants matching personas
**Mitigation**: {{RECRUITMENT_MITIGATION}}

**Risk**: Participants don't show up
**Mitigation**: {{NO_SHOW_MITIGATION}}

### Evaluation Risks

**Risk**: Technical issues during sessions
**Mitigation**: {{TECH_MITIGATION}}

**Risk**: Prototype not ready in time
**Mitigation**: {{PROTOTYPE_MITIGATION}}

### Schedule Risks

**Risk**: Evaluation timeline conflicts with development
**Mitigation**: {{SCHEDULE_MITIGATION}}

---

## Budget Breakdown

| Item | Cost | Quantity | Total |
|------|------|----------|-------|
| Participant incentives | {{INCENTIVE}} | {{COUNT}} | {{TOTAL}} |
| Recruitment fees | {{RECRUITMENT_FEE}} | - | {{TOTAL}} |
| Recording equipment | {{EQUIPMENT}} | - | {{TOTAL}} |
| Analysis software | {{SOFTWARE}} | - | {{TOTAL}} |
| Misc supplies | {{MISC}} | - | {{TOTAL}} |
| **TOTAL** | | | **{{GRAND_TOTAL}}** |

---

## Timeline

{{TIMELINE_GANTT}}

```mermaid
gantt
    title Evaluation Timeline
    dateFormat  YYYY-MM-DD
    section Preparation
    Recruit participants       :{{RECRUIT_START}}, {{RECRUIT_DURATION}}d
    Prepare materials         :{{PREP_START}}, {{PREP_DURATION}}d
    section Cycle 1
    Low-fi testing           :{{C1_START}}, {{C1_DURATION}}d
    Analysis & iteration     :{{C1_ANALYSIS}}, {{C1_ANALYSIS_DURATION}}d
    section Cycle 2
    Med-fi testing           :{{C2_START}}, {{C2_DURATION}}d
    Analysis & iteration     :{{C2_ANALYSIS}}, {{C2_ANALYSIS_DURATION}}d
    section Cycle 3
    High-fi testing          :{{C3_START}}, {{C3_DURATION}}d
    Final analysis           :{{C3_ANALYSIS}}, {{C3_ANALYSIS_DURATION}}d
    section Reporting
    Write findings report    :{{REPORT_START}}, {{REPORT_DURATION}}d
    Stakeholder presentation :{{PRESENT_DATE}}, 1d
```

---

## Success Criteria for Evaluation Plan

This evaluation plan succeeds if:

- [ ] All personas are represented in participant pool
- [ ] Sample size is adequate for detecting major usability issues
- [ ] Ethical requirements are met (consent, privacy, withdrawal rights)
- [ ] Budget and schedule constraints are respected
- [ ] Findings lead to actionable design improvements
- [ ] Iterative cycles show measurable improvement
- [ ] Stakeholders are satisfied with rigor and insights

---

**Plan Version**: {{VERSION}}
**Last Updated**: {{UPDATED_AT}}
**Next Review**: {{NEXT_REVIEW}}
