# 🧠 DinaCharya – Agentic AI Demo for iOS

**DinaCharya** is a GenAI-powered planning agent built as part of the **SwiftCircle** event.
It showcases how iOS developers can harness GPT models and prompts to build intelligent agents.
The project demonstrates agentic AI concepts applied to personal planning and productivity.
A practical guide for integrating LLMs and prompt engineering into real iOS applications.

---

## 📂 Folder Structure

DinaCharya/
├── Views/
│ └── ContentView.swift
│ # SwiftUI view that presents the checklist UI
│
├── ViewModels/
│ └── ChecklistViewModel.swift
│ # Manages the state and logic for checklist generation
│
├── Services/
│ ├── JugaadGPT.swift
│ └── LLMServiceable.swift
│ # Handles prompt creation and defines protocol for LLM interaction
│
├── Agents/
│ ├── ChecklistGenerating.swift
│ ├── LLMAIClient.swift
│ └── PromptBuilder.swift
│ # Agent layer responsible for defining prompts, communicating with OpenAI,
│ # and interpreting responses
│
├── Models/
│ └── ChecklistItem.swift
│ # Simple struct model for checklist items
│
├── SupportingFiles/
│ └── AppInfo.plist
│ # Contains configuration like the OpenAI API Key


## 🔑 Configuration

Before making any API requests, add your [OpenAI API Key](https://platform.openai.com/account/api-keys) to `AppInfo.plist` using:

```xml
<key>OPENAI_API_KEY</key>
<string>your-api-key-here</string>
```

![Dinacharya](https://github.com/user-attachments/assets/322779b6-9521-41e8-a993-7f9d24758634)



