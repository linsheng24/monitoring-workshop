resource "helm_release" "ingress_nginx" {
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  chart            = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = "4.10.1"

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
}

resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true
  chart            = "argo-cd"
  repository       = "https://argoproj.github.io/argo-helm"
  version          = "5.46.2"

  set {
    name  = "server.service.type"
    value = "ClusterIP"
  }

  set {
    name  = "controller.clusterRole.create"
    value = "true"
  }

  values = [<<EOF
server:
  extraArgs:
    - --insecure
EOF
  ]
}

resource "kubectl_manifest" "argocd_cm" {
  yaml_body = <<-YAML
    apiVersion: v1
    data:
      application.instanceLabelKey: argocd.argoproj.io/instance
      accounts.devops: apiKey,login
    kind: ConfigMap
    metadata:
      annotations:
        meta.helm.sh/release-name: argocd
        meta.helm.sh/release-namespace: argocd
      labels:
        app.kubernetes.io/component: server
        app.kubernetes.io/instance: argocd
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/name: argocd-cm
        app.kubernetes.io/part-of: argocd
      name: argocd-cm
      namespace: argocd
  YAML

  depends_on = [helm_release.argocd]
}

resource "kubectl_manifest" "argocd_rbac_cm" {
  yaml_body = <<-YAML
    apiVersion: v1
    kind: ConfigMap
    metadata:
      annotations:
        meta.helm.sh/release-name: argocd
        meta.helm.sh/release-namespace: argocd
      labels:
        app.kubernetes.io/component: server
        app.kubernetes.io/instance: argocd
        app.kubernetes.io/managed-by: Helm
        app.kubernetes.io/name: argocd-rbac-cm
        app.kubernetes.io/part-of: argocd
      name: argocd-rbac-cm
      namespace: argocd
    data:
      policy.csv: |
        p, role:admin, applications, *, */*, allow
        p, role:readonly, applications, get, */*, allow
        g, admin, role:admin
        g, devops, role:admin
  YAML

  depends_on = [kubectl_manifest.argocd_cm]
}