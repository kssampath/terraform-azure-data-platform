"""
Azure architecture diagram for the EDH pre-prod Terraform config.
Renders with the official Azure icon set via mingrammer 'diagrams'.

Requires: pip install diagrams  +  graphviz (dot) on PATH.
Run: python architecture.py  ->  produces preprd_architecture.png
"""
from diagrams import Diagram, Cluster, Edge
from diagrams.azure.general import Resourcegroups
from diagrams.azure.network import VirtualNetworks
from diagrams.azure.compute import VM
from diagrams.azure.web import AppServices
from diagrams.azure.analytics import Databricks, DataFactories, SynapseAnalytics
from diagrams.azure.storage import DataLakeStorage
from diagrams.azure.security import KeyVaults
from diagrams.azure.devops import ApplicationInsights
from diagrams.azure.analytics import LogAnalyticsWorkspaces

graph_attr = {
    "fontsize": "16",
    "bgcolor": "white",
    "pad": "0.6",
    "splines": "ortho",
    "nodesep": "0.6",
    "ranksep": "0.9",
}

with Diagram(
    "EDH Pre-prod — Azure (East US 2)",
    filename="preprd_architecture",
    show=False,
    direction="TB",
    graph_attr=graph_attr,
    outformat="png",
):
    rgs = Resourcegroups("Resource groups\n(7 RGs)")

    with Cluster("Azure subscription — EDH pre-prod"):
        with Cluster("Virtual network  10.40.48.0/20"):
            vnet = VirtualNetworks("Virtual network")

            with Cluster("Compute"):
                vm = VM("CTRM VM\n(RHEL)")
                app = AppServices("App service")
                dbx = Databricks("Databricks")

            with Cluster("Data & analytics"):
                storage = DataLakeStorage("ADLS Gen2")
                adf = DataFactories("Data factory")
                syn = SynapseAnalytics("Synapse")

            with Cluster("Security"):
                kv = KeyVaults("Key vault")

        with Cluster("Monitoring"):
            appin = ApplicationInsights("App insights")
            law = LogAnalyticsWorkspaces("Log analytics")

    # Foundation: everything depends on the resource groups
    rgs >> Edge(color="#5f5e5a") >> vnet

    # VNet provides subnets to compute
    vnet >> Edge(label="subnet", color="#0078D4") >> vm
    vnet >> Edge(label="subnet", color="#0078D4") >> dbx

    # Private endpoints into the PEP subnet
    pe = Edge(label="private endpoint", color="#0078D4", style="dashed")
    vnet >> pe >> app
    vnet >> pe >> storage
    vnet >> pe >> adf
    vnet >> pe >> syn
    vnet >> pe >> kv

    # Monitoring wiring
    appin >> Edge(color="#5f5e5a", style="dotted") >> law
