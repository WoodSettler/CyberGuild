"""Check installed files and links; does not claim harness discovery or behavior."""
import argparse
import hashlib
from pathlib import Path
import re

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--home', type=Path, default=Path.home())
parser.add_argument('--package', type=Path)
args = parser.parse_args()

def validate(root):
    required = ['SKILL.md', 'registry/成员索引.md', 'protocol/QuestBoard.md',
                'templates/QuestBoard/成员.md', 'templates/QuestBoard/消息列表.md',
                'templates/QuestBoard/AGENTS.md', 'templates/QuestBoard/CLAUDE.md']
    required += ['registry/profiles/' + name + '.md' for name in ['Claire', 'Aster', 'Seek']]
    for rel in required:
        if not (root / rel).is_file():
            raise SystemExit(f'Missing: {root / rel}')
    for file in root.rglob('*.md'):
        for link in re.findall(r'\]\(([^)]+)\)', file.read_text(encoding='utf-8')):
            if '://' in link or link.startswith('#'):
                continue
            target = (file.parent / link.split('#')[0]).resolve()
            if not target.is_relative_to(root.resolve()) or not target.exists():
                raise SystemExit(f'Invalid package reference: {file}: {link}')
    return {str(p.relative_to(root)): hashlib.sha256(p.read_bytes()).hexdigest()
            for p in root.rglob('*') if p.is_file()}

if args.package:
    validate(args.package)
    print('PASS: package completeness and internal references')
else:
    roots = {name: args.home / folder / 'skills/guild-appoint'
             for name, folder in [('Codex', '.agents'), ('Claude Code', '.claude'), ('DSH', '.dsh')]}
    manifests = {name: validate(path) for name, path in roots.items()}
    for name, path in roots.items():
        print(f'PASS: {name}: {path} -> {path.resolve()}')
    if any(m != manifests['Codex'] for m in manifests.values()):
        raise SystemExit('FAIL: installed content differs')
    print('PASS: all three installations contain identical files')
    print('Shared target:', len({p.resolve() for p in roots.values()}) == 1)
    print('Harness discovery, invocation and appointment behavior require live-session checks.')