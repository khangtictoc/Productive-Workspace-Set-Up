#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Copyright 2017 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

from __future__ import print_function
import itertools
import os.path
import sys

try:
    xrange  # Python 2
except NameError:
    xrange = range  # Python 3


def main():
    # (alias, full, allow_when_oneof, incompatible_with)
    cmds = [('k', 'kubectl', None, None)]

    globs = [
        ('sys', '--namespace=kube-system', None, None),
    ]

    ops = [
        ('a', 'apply --recursive -f', None, None),
        ('ak', 'apply -k', None, ['sys']),
        ('k', 'kustomize', None, ['sys']),
        ('ex', 'exec -i -t', None, None),
        ('lo', 'logs -f', None, None),
        ('lop', 'logs -f -p', None, None),
        ('p', 'proxy', None, ['sys']),
        ('pf', 'port-forward', None, ['sys']),
        ('g', 'get', None, None),
        ('d', 'describe', None, None),
        ('rm', 'delete', None, None),
        ('run', 'run --rm --restart=Never --image-pull-policy=IfNotPresent -i -t', None, None),
        ('c', 'create', None, None),
        # Personal use
        ('av', 'apply view-last-applied', None, None),
        ('rr', 'rollout restart', None, None),
        ('pa', 'patch', None, None),
        ('pafin', '''patch -p '{"metadata":{"finalizers":null}}' --type=merge''', None, None),
        ]

    res = [
        ('po', 'pods', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('dep', 'deployment', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('sts', 'statefulset', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('svc', 'service', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('ing', 'ingress', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('cm', 'configmap', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('sec', 'secret', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('no', 'nodes', ['g', 'd'], ['sys']),
        ('ns', 'namespace', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        # Personal use
        ('pv', 'persistentvolumes', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('pvc', 'persistentvolumeclaims', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('sa', 'serviceaccount', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('ro', 'role', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('cro', 'clusterrole', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('rob', 'rolebindings', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('crob', 'clusterrolebindings', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('ds', 'daemonset', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('hpa', 'horizontalpodautoscalers', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        ('crd', 'customresourcedefinition', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], ['sys']),
        # Custom resources
        # -- External Secrets
        ('esec', 'externalsecret', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], None),
        ('ss', 'secretstore', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], None),
        ('cesec', 'clusterexternalsecrets', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], None),
        # -- ArgoCD
        ('app', 'applications', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], None),
        ('ap', 'appprojects', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], None),
        ('as', 'applicationsets', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], None),
        # -- KEDA (Kubernetes-based Event Driven Autoscaling)
        ('sj', 'scaledjob', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], None),
        ('so', 'scaledobject', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], None),
        ('sm', 'servicemonitor', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], None),
        # -- Grafana Stack
        ('pr', 'prometheusrule', ['g', 'd', 'rm', 'c', 'av', 'pa', 'pafin'], None),
        ]
    #
    res_types = [r[0] for r in res]

    args = [
        ('oyaml', '-o=yaml', ['g'], ['owide', 'ojson', 'sl']),
        ('owide', '-o=wide', ['g'], ['oyaml', 'ojson']),
        ('ojson', '-o=json', ['g'], ['owide', 'oyaml', 'sl']),
        ('all', '--all-namespaces', ['g', 'd'], ['rm', 'f', 'no', 'sys']),
        ('sl', '--show-labels', ['g'], ['oyaml', 'ojson'], None),
        ('all', '--all', ['rm'], None), # caution: reusing the alias
        ('w', '--watch', ['g'], ['oyaml', 'ojson', 'owide']),
        ]

    # these accept a value, so they need to be at the end and
    # mutually exclusive within each other.
    positional_args = [('f', '--recursive -f', ['g', 'd', 'rm'], res_types + ['all'
        , 'l', 'sys']), ('l', '-l', ['g', 'd', 'rm'], ['f',
        'all']), ('n', '--namespace', ['g', 'd', 'rm',
        'lo', 'ex', 'pf'], ['ns', 'no', 'sys', 'all'])]

    # [(part, optional, take_exactly_one)]
    parts = [
        (cmds, False, True),
        (globs, True, False),
        (ops, True, True),
        (res, True, True),
        (args, True, False),
        (positional_args, True, True),
        ]

    shellFormatting = {
        "bash": "alias {}='{}'",
        "zsh": "alias {}='{}'",
        "fish": "abbr --add {} \"{}\"",
    }

    shell = sys.argv[1] if len(sys.argv) > 1 else "bash"
    if shell not in shellFormatting:
        raise ValueError("Shell \"{}\" not supported. Options are {}"
                        .format(shell, [key for key in shellFormatting]))

    out = gen(parts)

    # prepare output
    if not sys.stdout.isatty():
        header_path = \
            os.path.join(os.path.dirname(os.path.realpath(__file__)),
                'license_header')
        with open(header_path, 'r') as f:
            print(f.read())

    seen_aliases = set()

    for cmd in out:
        alias = ''.join([a[0] for a in cmd])
        command = ' '.join([a[1] for a in cmd])

        if alias in seen_aliases:
            print("Alias conflict detected: {}".format(alias), file=sys.stderr)

        seen_aliases.add(alias)

        print(shellFormatting[shell].format(alias, command))


def gen(parts):
    out = [()]
    for (items, optional, take_exactly_one) in parts:
        orig = list(out)
        combos = []

        if optional and take_exactly_one:
            combos = combos.append([])

        if take_exactly_one:
            combos = combinations(items, 1, include_0=optional)
        else:
            combos = combinations(items, len(items), include_0=optional)

        # permutate the combinations if optional (args are not positional)
        if optional:
            new_combos = []
            for c in combos:
                new_combos += list(itertools.permutations(c))
            combos = new_combos

        new_out = []
        for segment in combos:
            for stuff in orig:
                if is_valid(stuff + segment):
                    new_out.append(stuff + segment)
        out = new_out
    return out


def is_valid(cmd):
    return is_valid_requirements(cmd) and is_valid_incompatibilities(cmd)


def is_valid_requirements(cmd):
    parts = {c[0] for c in cmd}

    for i in range(0, len(cmd)):
        # check at least one of requirements are in the cmd
        requirements = cmd[i][2]
        if requirements and len(parts & set(requirements)) == 0:
            return False

    return True


def is_valid_incompatibilities(cmd):
    parts = {c[0] for c in cmd}

    for i in range(0, len(cmd)):
        # check none of the incompatibilities are in the cmd
        incompatibilities = cmd[i][3]
        if incompatibilities and len(parts & set(incompatibilities)) > 0:
            return False

    return True


def combinations(a, n, include_0=True):
    l = []
    for j in xrange(0, n + 1):
        if not include_0 and j == 0:
            continue

        cs = itertools.combinations(a, j)

        # check incompatibilities early
        cs = (c for c in cs if is_valid_incompatibilities(c))

        l += list(cs)

    return l


def diff(a, b):
    return list(set(a) - set(b))


if __name__ == '__main__':
    main()
