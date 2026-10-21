# CyberGuild · 赛博佣兵公会

[English](README.md) | **简体中文**

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

## 安装检查与 DSH 接入

先用上面的 npx 命令安装并选择 Symlink。Windows 用户再运行：

```powershell
& "$HOME\.agents\skills\guild-appoint\scripts\connect-dsh.ps1"
python -X utf8 "$HOME\.agents\skills\guild-appoint\scripts\check-install.py"
```

接入脚本将 DSH 链接到共享安装，不会复制另一份内容；重复运行无变化。同名旧安装保存在 DSH 的 skill-backups 目录，失败时尝试恢复。支持 -Source 和 -SkillsDirectory 指定自定义路径。当前适配脚本面向 Windows。

更新使用 `npx skills update`，随后重新运行检查脚本。先解除 DSH 的目录链接，再卸载共享安装，避免留下悬空链接；Windows 可用 `[IO.Directory]::Delete("$HOME\.dsh\skills\guild-appoint")` 仅删除目录链接，执行前须确认它确为链接，不能递归删除目标内容。

## 验证状态

文件完整性、内部引用、三方文件一致性与链接可由脚本检查。真实会话中的 skill 发现、显式调用、按需读取、用户指令覆盖行为仍需逐个平台验证；文件检查通过不代表这些行为已经通过。

最小会话验收：在临时项目明确任命一个成员；观察只读取入口、索引与项目成员表；确认未自动任命同事或读取全部档案；通过用户直接指令调整一项同事任务，检查覆盖范围与通知。不能据模型口头声称代替工具读取记录。

语言切换覆盖项目说明；运行协议保持单一版本，避免翻译产生两套规则。成员可按用户语言回复。默认档案随包公开，项目状态不进入发布包。