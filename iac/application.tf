resource "kubectl_manifest" "prometheus_stack_argocd_application" {
  yaml_body = <<-YAML
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: prometheus-stack
      namespace: argocd
      labels:
        app: prometheus-stack
    spec:
      destination:
        namespace: monitoring
        server: 'https://kubernetes.default.svc'
      source:
        path: charts/prometheus-stack
        repoURL: '${var.repository_url}'
        targetRevision: main
      project: default
      syncPolicy:
        pruneLast: true
        automated:
          prune: true
          selfHeal: true
        syncOptions:
          - ServerSideApply=true
          - CreateNamespace=true
  YAML

  depends_on = [
    helm_release.argocd,
  ]
}

resource "kubectl_manifest" "web_app_application" {
  yaml_body = <<-YAML
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: web-app
      namespace: argocd
      labels:
        app: web-app
    spec:
      destination:
        namespace: web
        server: 'https://kubernetes.default.svc'
      source:
        path: charts/web-app
        repoURL: '${var.repository_url}'
        targetRevision: main
      project: default
      syncPolicy:
        pruneLast: true
        automated:
          prune: true
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
  YAML

  depends_on = [
    helm_release.argocd,
  ]
}

resource "kubectl_manifest" "cronjob_app_application" {
  yaml_body = <<-YAML
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: cronjob-app
      namespace: argocd
      labels:
        app: cronjob-app
    spec:
      destination:
        namespace: cronjob
        server: 'https://kubernetes.default.svc'
      source:
        path: charts/cronjob-app
        repoURL: '${var.repository_url}'
        targetRevision: main
      project: default
      syncPolicy:
        pruneLast: true
        automated:
          prune: true
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
  YAML

  depends_on = [
    helm_release.argocd,
  ]
}

resource "kubectl_manifest" "minio_application" {
  yaml_body = <<-YAML
    apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: minio
      namespace: argocd
      labels:
        app: minio
    spec:
      destination:
        namespace: storage
        server: 'https://kubernetes.default.svc'
      source:
        path: charts/minio
        repoURL: '${var.repository_url}'
        targetRevision: main
      project: default
      syncPolicy:
        pruneLast: true
        automated:
          prune: true
          selfHeal: true
        syncOptions:
          - CreateNamespace=true
  YAML

  depends_on = [
    helm_release.argocd,
  ]
}