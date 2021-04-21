<dict-public-entry>
	<div class="row">
		<div class="col s10 offset-s1">
			<h3 class="header"><a href="#/{ this.props.dictId }">{ this.props.dictDetails.title }</a></h3>
		</div>
	</div>
	<template if={ this.props.dictDetails.public }>
		<div class="divider"></div>
		<div class="row">
			<div class="col s9">
				<entry-view is="entry-view" dict-id={ this.props.dictId } entry-id={ this.props.entryId }></entry-view>
			</div>
			<div class="col s3">
				<ul class="nabes">
					<li each={ entry in this.moreEntries} active={entry.id == this.props.entryId}><a href="#/{ this.props.dictId }/{ entry.id }">{ entry.titlePlain }</a></li>
				</ul>
			</div>
		</div>
		<div class="divider"></div>
		<div class="section">
			{ this.props.dictDetails.licence }
		</div>
	</template>

	<script>
		export default {
			moreEntries: [],
			entryId: '',

			loadMoreEntries() {
				$.get("/" + this.props.dictId + "/" + this.props.entryId + "/nabes.json", (response) => {
					if (response.nabes) {
						this.moreEntries = response.nabes;
						this.update();
					}
				});
			},
			onMounted() {
				console.log('list dict entry '+ this.props.dictId+'-'+this.props.entryId)
				this.entryId = this.props.entryId;
				this.props.loadDictDetail();
				this.loadMoreEntries();
				console.log(this.props)
			},

			onUpdated() {
				if (this.entryId != this.props.entryId) {
					this.entryId = this.props.entryId;
					this.loadMoreEntries();
				}
			}
		}
	</script>

	<style>
		.nabes li a:hover {text-decoration: underline;}
		.nabes li[active=active] a {background-color: #ffccbc;}
	</style>
</dict-public-entry>
