# CyberGuild · 赛博佣兵公会

跨 harness 的 AI Agent 任命与项目协作 skill。成员身份由用户任命，不由模型或工具决定。用户指令优先于成员间安排。

## 安装

Claude Code 与 Codex：

```sh
npx skills add WoodSettler/CyberGuild --skill guild-appoint -a claude-code codex -g
```

本地开发可把仓库地址替换为本仓库路径。通用安装器见 https://github.com/vercel-labs/skills 。

DeepSeek Harness 使用相同的 skill 目录格式，安装位置为 `~/.dsh/skills/guild-appoint/`。将完整的 `skills/guild-appoint` 目录复制或链接到这里即可；不要只复制 SKILL.md。尚未确认通用安装器支持 DSH 的 agent 名称，因此不提供未经验证的 `-a dsh` 命令。

Windows 本地仓库链接示例（目标不存在时执行；保留已有同名安装）：

```powershell
New-Item -ItemType Directory -Force -Path "$HOME\.dsh\skills"
New-Item -ItemType Junction -Path "$HOME\.dsh\skills\guild-appoint" -Target "<仓库路径>\skills\guild-appoint"
```

安装不等于任命。明确调用：

> 使用 guild-appoint，在当前项目中任命你为 Aster。

原生 skill 入口语法由 harness 决定；也可显式读取安装目录的 SKILL.md。Codex 包含显式调用策略，其他 harness 仍须遵守入口中的用户明确任命要求。尚未完成三种 harness 的端到端行为验证。

## 自包含发布结构

```text
skills/guild-appoint/
  SKILL.md
  agents/openai.yaml
  registry/
    成员索引.md
    profiles/Claire.md
    profiles/Aster.md
    profiles/Seek.md
  protocol/QuestBoard.md
  templates/QuestBoard/
```

[共享入口](skills/guild-appoint/SKILL.md) 及其所有运行依赖均在一个 skill 目录中，复制安装后无需定位源仓库。自包含不等于默认全量读取：任命只加载入口、成员摘要和目标项目的成员表；档案、协议与消息按需展开。

## 默认公开队伍

| 成员 | 专长 |
| --- | --- |
| Claire · Chief Thought Officer | 高价值思考、方案与重要取舍 |
| Aster · Chief Realization Officer | 长期实现计划、分阶段任务书与目标一致性 |
| Seek · Chief Exploration Officer & Execution Officer | 准确执行任务书、搜索与整理情报 |

[成员索引](skills/guild-appoint/registry/成员索引.md) 与档案是随包公开的默认版本，不包含真实会话、私人历史或用户项目数据。它们不是运行中的任命。头衔不限制其他能力，也不构成上下级关系；性格与履历中尚未提供的内容不虚构。

用户可明确指定外部自定义名册，安装更新不会负责迁移该名册。未指定时使用包内默认队伍。默认职责由名册维护，项目成员表只记录任命与项目差异。

## QuestBoard

每个合作项目有自己的 QuestBoard：成员表、消息列表和逐条详情。两个单句入口 AGENTS.md 与 CLAUDE.md 只允许本项目已获用户任命的成员接发任务。模板未授权任何成员。

这是行为约定，不是操作系统权限；用户指令仅覆盖其涉及范围，接收成员负责通知受影响同事。项目运行数据保留在目标工作区，不写回已安装 skill。

同一项目同一身份默认一个活跃会话，用户可明确接替或分身。文件不会自动唤醒会话；本包不包含后台服务或调度器，OrKi 可作为独立执行工具使用。
