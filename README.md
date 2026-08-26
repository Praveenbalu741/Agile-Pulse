[![Netlify Status](https://api.netlify.com/api/v1/badges/87061ddf-470e-4e37-a103-caff8a406576/deploy-status)](https://app.netlify.com/projects/agile-pulse-uiux/deploys)
# ⚡ Agile Pulse — AI-Powered Internal Culture & Ops Platform

### Next-Gen Agile Collaboration & Sentiment Intelligence Platform

An AI-driven enterprise platform for agile teams featuring automated standup sentiment analysis, drag-and-drop sprint tracking, gamified recognition, and deep team culture analytics — eliminating burnout risks and boosting daily engagement.

🔗 **Live Demo:** [agile-pulse-uiux.netlify.app](https://agile-pulse-uiux.netlify.app/)

---

## 📌 About This Repository

This repository hosts the front-end showcase, UI/UX case study presentation, and interactive web dashboard for the **Agile Pulse** platform, deployed automatically via Netlify.

It serves as the public-facing application and design portfolio for the project — allowing recruiters, professors, and collaborators to explore the design decisions, wireframes, and live interactive UI — backed by a robust Java Spring Boot backend engine.

### Current Contents

| File / Folder | Purpose |
| --- | --- |
| `index.html` | Main interactive web application & case study showcase |
| `assets/` | Static visual assets (Figma exports, branding icons, design tokens) |
| `src/js/` | Frontend interactivity (Kanban drag-and-drop, Chart.js analytics, sentiment UI) |
| `src/css/` | Tailwind CSS configuration & custom glassmorphism styles |
| `backend/` | Java Spring Boot REST APIs, JPA entities, DTOs, & AI Sentiment Analysis Engine |

---

## 🚀 Getting Started

### 1. Front-End Live Preview

To run the front-end showcase locally:

```bash
git clone https://github.com/Praveenbalu741/Agile-Pulse-UIUX.git
cd Agile-Pulse-UIUX

```

Open `index.html` directly in your browser, or launch using Python/Node local servers:

```bash
# Using Python
python -m http.server 8000

# Using Node's http-server
npx http-server .

```

Visit `http://localhost:8000` to view the application. Every push to `main` automatically updates the live Netlify deployment.

### 2. Backend Java Service (Spring Boot)

To run the Java backend engine locally:

```bash
cd backend
./mvnw spring-boot:run

```

The Spring Boot backend will start on `http://localhost:8080` with an embedded H2 database and pre-populated seed data.

---

## 🎯 Project Vision

Agile processes shouldn't feel like rigid administrative overhead. **Agile Pulse** transforms daily standups into intelligent insights by pairing user-centric UI/UX design with automated backend analytics.

```text
Standup & Activity Input
           │
           ▼
Java Spring Boot REST Controller (Java 17 / Spring Boot 3)
           │
           ▼
AI Sentiment & Risk Analysis Service
    ├─ NLP Keyword Heuristics & Sentiment Scorer (-1.0 to +1.0)
    ├─ Blocker & Burnout Early Warning System
    └─ Gamification & XP Engine (Streaks, Badges, Leaderboard)
           │
           ▼
Real-Time Actuation & Analytics Layer (WebSocket + REST APIs)
           │
           ▼
Live UI/UX Web Dashboard & Executive Heatmap

```

---

## 🏎️ Signature Features

* 🧠 **AI-Powered Standup Sentiment Analysis** — Automatically evaluates daily standup entries to calculate sentiment scores (-1.0 to +1.0) and flag critical blockers before they impact sprint velocity.
* 📋 **Interactive Kanban Sprint Board** — Drag-and-drop task tracking board (To-Do, In Progress, Review, Done) with real-time API status persistence.
* 🌟 **"Pulse Stars" Peer Recognition Wall** — Peer-to-peer Kudos platform with customizable animated badges, dynamic celebration micro-interactions, and instant confetti FX.
* 🏆 **Gamified XP & Leaderboard System** — Track daily standup streaks, earn unlockable achievement cards (*Standup Hero*, *Bug Slayer*), and build morale.
* 🔄 **Sprint Retrospective Matrix** — Dynamic "Start / Stop / Continue" retro board with live upvoting and one-click conversion of retro ideas into sprint tasks.
* 🎨 **UI/UX Case Study Showcase** — Embedded portfolio section presenting original wireframes, design rationale, color token palettes, and component architecture created in Figma, Adobe Illustrator, and Photoshop.

---

## 🛠️ Tech Stack

| Layer | Technology |
| --- | --- |
| **Backend Engine** | Java 17+, Spring Boot 3, Spring Data JPA, Spring Security, Lombok |
| **AI / Intelligence** | Java Sentiment Analysis Service, NLP Heuristic Rules, Custom DTO Mappers |
| **Database** | H2 Database (In-Memory Development), PostgreSQL (Production) |
| **Frontend Framework** | HTML5, Tailwind CSS, Vanilla JavaScript (ES6+), Chart.js, SortableJS |
| **UI/UX Design Stack** | Figma (Wireframes & Prototypes), Adobe Illustrator, Adobe Photoshop |
| **Deployment** | Netlify (Frontend), Docker Compose (Full Stack Deployment) |

---

## 📊 Why Agile Pulse?

Traditional agile dashboards focus purely on ticket numbers, ignoring team health and operational friction. Modern engineering research shows measurable benefits from integrated culture platforms:

* **35% faster identification** of critical blockers and burnout signals.
* **40% increase** in daily standup consistency through gamified streaks.
* **2.5x increase** in peer-to-peer recognition frequency across engineering workflows.

---

## 🤝 Contributing

This is an active full-stack individual project. Feedback, pull requests, and feature suggestions are welcome!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

Distributed under the **MIT License**. See `LICENSE` for more information.

---

## 👤 Author & Maintainer

**Praveenbalu741** — Full-Stack Developer & UI/UX Designer

🔗 **Live Application:** [agile-pulse-uiux.netlify.app](https://agile-pulse-uiux.netlify.app/)
