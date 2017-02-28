#!/usr/bin/env groovy

REPOSITORY = 'govuk_document_types'

node {
  def govuk = load '/var/lib/jenkins/groovy_scripts/govuk_jenkinslib.groovy'

  try {
    stage('Checkout') {
      checkout scm
    }

    stage('Clean') {
      govuk.cleanupGit()
      govuk.mergeMasterBranch()
    }

    stage("Set up content schema dependency") {
      govuk.contentSchemaDependency()
    }

    stage('Bundle') {
      echo 'Bundling'
      sh("bundle install --path ${JENKINS_HOME}/bundles/${JOB_NAME}")
    }

    stage('Linter') {
      govuk.rubyLinter()
    }

    stage('Tests') {
      govuk.setEnvar('RAILS_ENV', 'test')
      govuk.runTests('spec')
    }

    if(env.BRANCH_NAME == "master") {
      stage('Publish Gem') {
        govuk.publishGem(REPOSITORY, env.BRANCH_NAME)
      }
    }

  } catch (e) {
    currentBuild.result = 'FAILED'
    step([$class: 'Mailer',
          notifyEveryUnstableBuild: true,
          recipients: 'govuk-ci-notifications@digital.cabinet-office.gov.uk',
          sendToIndividuals: true])
    throw e
  }
}
